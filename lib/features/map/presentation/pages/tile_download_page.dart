import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/utils/tile_cache_manager.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:latlong2/latlong.dart';

/// Page for downloading offline map tiles
class TileDownloadPage extends ConsumerStatefulWidget {
  const TileDownloadPage({super.key});

  @override
  ConsumerState<TileDownloadPage> createState() => _TileDownloadPageState();
}

class _TileDownloadPageState extends ConsumerState<TileDownloadPage> {
  final MapController _mapController = MapController();

  // Download parameters
  LatLng _center = MapConstants.defaultCenter;
  double _radius = 5.0; // km
  int _minZoom = 10;
  int _maxZoom = 16;

  // Download state
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  int _downloadedTiles = 0;
  int _totalTiles = 0;
  String _statusMessage = '';

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Peta Offline'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfo,
          ),
        ],
      ),
      body: Column(
        children: [
          // Map preview
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _center,
                    initialZoom: 12,
                    onTap: (_, point) {
                      setState(() {
                        _center = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: MapConstants.osmTileUrl,
                      userAgentPackageName: 'com.example.geosurvey',
                      tileProvider: TileCacheManager.getTileProvider(),
                    ),
                    // Circle overlay showing download area
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: _center,
                          radius: _radius * 1000, // Convert km to meters
                          useRadiusInMeter: true,
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderColor: AppColors.primary,
                          borderStrokeWidth: 2,
                        ),
                      ],
                    ),
                    // Center marker
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _center,
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_pin,
                            color: AppColors.error,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Instructions
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Tap peta untuk pilih lokasi download',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Download settings
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengaturan Download',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),

                  // Radius slider
                  _buildSlider(
                    label: 'Radius Area',
                    value: _radius,
                    min: 1,
                    max: 20,
                    divisions: 19,
                    suffix: 'km',
                    onChanged: (value) => setState(() => _radius = value),
                  ),

                  // Min zoom slider
                  _buildSlider(
                    label: 'Zoom Minimum',
                    value: _minZoom.toDouble(),
                    min: 8,
                    max: 15,
                    divisions: 7,
                    suffix: '',
                    onChanged: (value) {
                      setState(() {
                        _minZoom = value.toInt();
                        if (_minZoom > _maxZoom) _maxZoom = _minZoom;
                      });
                    },
                  ),

                  // Max zoom slider
                  _buildSlider(
                    label: 'Zoom Maximum',
                    value: _maxZoom.toDouble(),
                    min: 10,
                    max: 18,
                    divisions: 8,
                    suffix: '',
                    onChanged: (value) {
                      setState(() {
                        _maxZoom = value.toInt();
                        if (_maxZoom < _minZoom) _minZoom = _maxZoom;
                      });
                    },
                  ),

                  const SizedBox(height: 8),

                  // Estimated tiles info
                  _buildInfoCard(),

                  const SizedBox(height: 16),

                  // Download progress
                  if (_isDownloading) _buildProgressCard(),

                  // Download button
                  if (!_isDownloading)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _startDownload,
                        icon: const Icon(Icons.download),
                        label: const Text('Mulai Download'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                  // Cancel button
                  if (_isDownloading)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isDownloading = false;
                            _statusMessage = 'Download dibatalkan';
                          });
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Batalkan'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String suffix,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              '${value.toStringAsFixed(suffix.isEmpty ? 0 : 1)} $suffix',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          onChanged: _isDownloading ? null : onChanged,
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    // Estimate tiles (rough calculation)
    final estimatedTiles = _estimateTileCount();
    final estimatedSize = (estimatedTiles * 15 / 1024).toStringAsFixed(
      1,
    ); // ~15KB per tile

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info, size: 16, color: AppColors.info),
              SizedBox(width: 8),
              Text(
                'Estimasi Download',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Tiles: ~$estimatedTiles'),
          Text('Ukuran: ~$estimatedSize MB'),
          const SizedBox(height: 4),
          const Text(
            'Pastikan koneksi internet stabil',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Downloading...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${(_downloadProgress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _downloadProgress,
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(height: 8),
          Text(
            '$_downloadedTiles / $_totalTiles tiles',
            style: const TextStyle(fontSize: 12),
          ),
          if (_statusMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _statusMessage,
                style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  int _estimateTileCount() {
    // Rough estimation based on zoom levels and radius
    int total = 0;
    for (int zoom = _minZoom; zoom <= _maxZoom; zoom++) {
      final tilesPerSide = (_radius / 10 * (1 << zoom)).ceil();
      total += tilesPerSide * tilesPerSide;
    }
    return total;
  }

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
      _downloadedTiles = 0;
      _totalTiles = 0;
      _statusMessage = 'Memulai download...';
    });

    try {
      final store = TileCacheManager.getStore();

      // Create download region (circle)
      final region = CircleRegion(
        _center,
        _radius * 1000, // Convert to meters
      );

      // Start download
      final downloadable = region.toDownloadable(
        minZoom: _minZoom,
        maxZoom: _maxZoom,
        options: TileLayer(urlTemplate: MapConstants.osmTileUrl),
      );

      final download = store.download.startForeground(
        region: downloadable,
        parallelThreads: 10,
        maxBufferLength: 100,
      );

      // Listen to progress
      await for (final progress in download.downloadProgress) {
        if (!_isDownloading) {
          break;
        }

        setState(() {
          _downloadedTiles = progress.successfulTilesCount;
          _totalTiles = progress.maxTilesCount;
          _downloadProgress = progress.percentageProgress / 100;
          _statusMessage = 'Downloading tiles...';
        });
      }

      if (_isDownloading && mounted) {
        setState(() {
          _isDownloading = false;
          _statusMessage = 'Download selesai!';
        });

        TopNotification.showSuccess(
          context,
          'Download selesai! $_downloadedTiles tiles tersimpan',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _statusMessage = 'Error: $e';
        });

        TopNotification.showError(context, 'Download gagal: $e');
      }
    }
  }

  void _showInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tentang Download Offline'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Download peta offline memungkinkan Anda menggunakan aplikasi tanpa koneksi internet.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Tips:'),
              SizedBox(height: 8),
              Text('• Pilih area yang akan sering Anda kunjungi'),
              Text(
                '• Zoom level lebih tinggi = detail lebih baik tapi ukuran lebih besar',
              ),
              Text('• Download saat koneksi WiFi untuk menghemat kuota'),
              Text('• Tiles tersimpan permanen sampai Anda hapus'),
              SizedBox(height: 12),
              Text(
                'Catatan: Tiles dari OpenStreetMap, pastikan mengikuti usage policy mereka.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }
}
