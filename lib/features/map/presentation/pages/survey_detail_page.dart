import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:geosurvey/core/utils/geojson_exporter.dart';
import 'package:geosurvey/core/utils/file_exporter.dart';
import 'package:geosurvey/core/utils/pdf_exporter.dart';
import 'package:geosurvey/core/utils/geocoding_service.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:geosurvey/core/database/app_database.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class SurveyDetailPage extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailPage({super.key, required this.surveyId});

  @override
  ConsumerState<SurveyDetailPage> createState() => _SurveyDetailPageState();
}

class _SurveyDetailPageState extends ConsumerState<SurveyDetailPage> {
  final MapController _mapController = MapController();
  final ScreenshotController _screenshotController = ScreenshotController();
  String? _fetchedAddress;
  bool _isLoadingAddress = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _fetchAddress(List<LatLng> vertices) async {
    if (_fetchedAddress != null || _isLoadingAddress) return;

    setState(() {
      _isLoadingAddress = true;
    });

    final address = await GeocodingService.getAddressFromPolygon(vertices);

    if (mounted) {
      setState(() {
        _fetchedAddress = address;
        _isLoadingAddress = false;
      });
    }
  }

  Future<void> _pickImage(String surveyId, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile == null) return;

      // Save to app directory (using FileExporter helper)
      final savedPath = await FileExporter.saveToFile(
        content: '', // Not used for copy
        filename: 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      // Copy file content
      await File(pickedFile.path).copy(savedPath);

      // Save to database
      await ref.read(surveyRepositoryProvider).addPhoto(surveyId, savedPath);

      if (mounted) {
        setState(() {}); // Refresh UI
        TopNotification.showSuccess(context, 'Foto berhasil ditambahkan');
      }
    } catch (e) {
      if (mounted) {
        TopNotification.showError(context, 'Gagal menambahkan foto: $e');
      }
    }
  }

  Future<void> _deletePhoto(int photoId) async {
    try {
      await ref.read(surveyRepositoryProvider).deletePhoto(photoId);
      if (mounted) {
        setState(() {}); // Refresh UI
        TopNotification.showSuccess(context, 'Foto dihapus');
      }
    } catch (e) {
      if (mounted) {
        TopNotification.showError(context, 'Gagal menghapus foto: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(surveyRepositoryProvider);

    return FutureBuilder(
      future: repository.getSurveyById(widget.surveyId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Survey')),
            body: const Center(child: Text('Survey tidak ditemukan')),
          );
        }

        final survey = snapshot.data!;
        final vertices = repository.parseVertices(survey.geometry);
        final dateFormat = DateFormat('dd MMMM yyyy, HH:mm');
        final center = vertices.isNotEmpty
            ? vertices.first
            : MapConstants.defaultCenter;

        return Scaffold(
          appBar: AppBar(
            title: Text(survey.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.ios_share),
                tooltip: 'Export',
                onPressed: () => _showExportMenu(context, survey, vertices),
              ),
            ],
          ),
          body: Column(
            children: [
              // Map View
              Expanded(
                flex: 2,
                child: Screenshot(
                  controller: _screenshotController,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: center,
                          initialZoom: 15,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.all,
                          ),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: MapConstants.osmTileUrl,
                            userAgentPackageName: 'com.example.geosurvey',
                          ),
                          if (vertices.length >= 2)
                            PolygonLayer(
                              polygons: [
                                Polygon(
                                  points: vertices,
                                  color: AppColors.polygonFill,
                                  borderColor: AppColors.polygonStroke,
                                  borderStrokeWidth: 3,
                                ),
                              ],
                            ),
                          MarkerLayer(
                            markers: vertices.asMap().entries.map((entry) {
                              return Marker(
                                point: entry.value,
                                width: 40,
                                height: 40,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.markerColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${entry.key + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      // Zoom Controls
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: Column(
                          children: [
                            FloatingActionButton.small(
                              heroTag: 'detail_zoom_in',
                              onPressed: () {
                                final currentZoom = _mapController.camera.zoom;
                                _mapController.move(
                                  _mapController.camera.center,
                                  currentZoom + 1,
                                );
                              },
                              backgroundColor: AppColors.surface,
                              foregroundColor: AppColors.primary,
                              child: const Icon(Icons.add),
                            ),
                            const SizedBox(height: 8),
                            FloatingActionButton.small(
                              heroTag: 'detail_zoom_out',
                              onPressed: () {
                                final currentZoom = _mapController.camera.zoom;
                                _mapController.move(
                                  _mapController.camera.center,
                                  currentZoom - 1,
                                );
                              },
                              backgroundColor: AppColors.surface,
                              foregroundColor: AppColors.primary,
                              child: const Icon(Icons.remove),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Details Panel
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detail Survey',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),

                        _DetailRow(
                          icon: Icons.calendar_today,
                          label: 'Tanggal Dibuat',
                          value: dateFormat.format(survey.createdAt),
                        ),
                        const SizedBox(height: 12),

                        _DetailRow(
                          icon: Icons.location_on,
                          label: 'Jumlah Titik',
                          value: '${vertices.length} titik',
                        ),
                        const SizedBox(height: 12),

                        // Address (from database or geocoding)
                        if (survey.address.isNotEmpty)
                          _DetailRow(
                            icon: Icons.location_city,
                            label: 'Alamat',
                            value: survey.address,
                          )
                        else if (_fetchedAddress != null)
                          _DetailRow(
                            icon: Icons.location_city,
                            label: 'Alamat (dari koordinat)',
                            value: _fetchedAddress!,
                          )
                        else if (_isLoadingAddress)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_city,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Mengambil alamat...',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          )
                        else
                          GestureDetector(
                            onTap: () => _fetchAddress(vertices),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Tap untuk ambil alamat dari koordinat',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.refresh,
                                  size: 16,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 12),

                        _DetailRow(
                          icon: Icons.crop_square,
                          label: 'Luas Area',
                          value: GeoCalculator.formatArea(survey.areaSize),
                          valueColor: AppColors.primary,
                        ),
                        const SizedBox(height: 12),

                        _DetailRow(
                          icon: Icons.straighten,
                          label: 'Keliling',
                          value: GeoCalculator.formatDistance(survey.perimeter),
                          valueColor: AppColors.primary,
                        ),
                        const SizedBox(height: 12),

                        const Divider(height: 32),

                        // Photos Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dokumentasi Foto',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () =>
                                  _showPhotoOptions(context, survey.id),
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: AppColors.primary,
                              ),
                              tooltip: 'Tambah Foto',
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        FutureBuilder<List<SurveyPhoto>>(
                          future: repository.getPhotos(survey.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: const Text(
                                  'Belum ada foto dokumentasi',
                                  style: TextStyle(color: Colors.grey),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }

                            final photos = snapshot.data!;
                            return SizedBox(
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: photos.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  final photo = photos[index];
                                  return Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(photo.path),
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 120,
                                                  height: 120,
                                                  color: Colors.grey.shade200,
                                                  child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey,
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () => _deletePhoto(photo.id),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        const Divider(height: 32),

                        // Coordinates section
                        Text(
                          'Koordinat Titik',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ...vertices.asMap().entries.map((entry) {
                          final index = entry.key;
                          final vertex = entry.value;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: [
                                // Point number
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Coordinates
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.my_location,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Lat: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            vertex.latitude.toStringAsFixed(6),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.place,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Lng: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            vertex.longitude.toStringAsFixed(6),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showExportMenu(
    BuildContext context,
    dynamic survey,
    List<LatLng> vertices,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.code, color: AppColors.primary),
              title: const Text('Export GeoJSON'),
              subtitle: const Text('Format standar untuk GIS'),
              onTap: () {
                Navigator.pop(context);
                _exportGeoJSON(context, survey, vertices);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image, color: AppColors.success),
              title: const Text('Export PNG Image'),
              subtitle: const Text('Screenshot peta sebagai gambar'),
              onTap: () {
                Navigator.pop(context);
                _exportImage(context, survey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: AppColors.error),
              title: const Text('Export PDF Report'),
              subtitle: const Text('Laporan lengkap dengan statistik'),
              onTap: () {
                Navigator.pop(context);
                _exportPDF(context, survey, vertices);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _exportGeoJSON(
    BuildContext context,
    dynamic survey,
    List<LatLng> vertices,
  ) async {
    try {
      // Generate GeoJSON
      final geoJson = GeoJsonExporter.surveyToGeoJson(
        id: survey.id,
        name: survey.name,
        vertices: vertices,
        areaSize: survey.areaSize,
        perimeter: survey.perimeter,
        createdAt: survey.createdAt,
        address: survey.address,
      );

      // Convert to formatted JSON string
      final jsonString = GeoJsonExporter.toJsonString(geoJson, pretty: true);

      // Generate filename
      final filename = GeoJsonExporter.generateFilename(survey.name);

      // Save and share
      await FileExporter.saveAndShare(
        content: jsonString,
        filename: filename,
        shareText:
            'Survey: ${survey.name}\nArea: ${GeoCalculator.formatArea(survey.areaSize)}',
      );

      if (context.mounted) {
        TopNotification.showSuccess(context, 'GeoJSON berhasil di-export!');
      }
    } catch (e) {
      if (context.mounted) {
        TopNotification.showError(context, 'Gagal export GeoJSON: $e');
      }
    }
  }

  void _exportImage(BuildContext context, dynamic survey) async {
    try {
      TopNotification.showInfo(context, 'Mengambil screenshot...');

      final imageBytes = await _screenshotController.capture();
      if (imageBytes == null) {
        throw Exception('Gagal mengambil screenshot');
      }

      final filename =
          'survey_${survey.name.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.png';

      // Save as binary
      final path = await FileExporter.saveToFile(
        content: String.fromCharCodes(imageBytes),
        filename: filename,
      );

      // Write bytes
      final file = await File(path).writeAsBytes(imageBytes);

      // Share
      await FileExporter.shareFile(
        filePath: file.path,
        filename: filename,
        text: 'Survey Map: ${survey.name}',
      );

      if (context.mounted) {
        TopNotification.showSuccess(context, 'Image berhasil di-export!');
      }
    } catch (e) {
      if (context.mounted) {
        TopNotification.showError(context, 'Gagal export image: $e');
      }
    }
  }

  void _exportPDF(
    BuildContext context,
    dynamic survey,
    List<LatLng> vertices,
  ) async {
    try {
      TopNotification.showInfo(context, 'Membuat PDF report...');

      // Capture screenshot first
      final mapScreenshot = await _screenshotController.capture();

      // Generate PDF
      final pdfBytes = await PdfExporter.generateSurveyReport(
        survey: survey,
        vertices: vertices,
        mapScreenshot: mapScreenshot,
      );

      final filename =
          'survey_${survey.name.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Save as binary
      final path = await FileExporter.saveToFile(
        content: '',
        filename: filename,
      );

      // Write bytes
      final file = await File(path).writeAsBytes(pdfBytes);

      // Share
      await FileExporter.shareFile(
        filePath: file.path,
        filename: filename,
        text: 'Laporan Survey: ${survey.name}',
      );

      if (context.mounted) {
        TopNotification.showSuccess(context, 'PDF report berhasil di-export!');
      }
    } catch (e) {
      if (context.mounted) {
        TopNotification.showError(context, 'Gagal export PDF: $e');
      }
    }
  }

  void _showPhotoOptions(BuildContext context, String surveyId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Foto (Kamera)'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(surveyId, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(surveyId, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
