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
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
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

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
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
                  child: FlutterMap(
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
