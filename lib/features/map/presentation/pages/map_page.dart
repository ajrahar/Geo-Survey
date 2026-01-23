import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/providers/drawing_state_provider.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:geosurvey/features/map/presentation/widgets/polygon_layer_widget.dart';
import 'package:geosurvey/features/map/presentation/widgets/drawing_toolbar.dart';
import 'package:geosurvey/features/map/presentation/widgets/info_panel.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final MapController _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawingState = ref.watch(drawingStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Survey'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: 'Download Peta Offline',
            onPressed: () {
              TopNotification.showInfo(
                context,
                'Fitur download peta akan segera tersedia',
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Widget
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: MapConstants.defaultCenter,
              initialZoom: MapConstants.defaultZoom,
              minZoom: MapConstants.minZoom,
              maxZoom: MapConstants.maxZoom,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onTap: (tapPosition, point) => _handleMapTap(point),
            ),
            children: [
              // OpenStreetMap Tile Layer
              TileLayer(
                urlTemplate: MapConstants.osmTileUrl,
                userAgentPackageName: 'com.example.geosurvey',
                tileProvider: NetworkTileProvider(),
              ),

              // Polygon and Markers Layer
              PolygonLayerWidget(mapController: _mapController),

              // Attribution Layer
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    MapConstants.osmAttribution,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),

          // Zoom Controls
          if (!drawingState.isDrawing &&
              drawingState.mode != DrawingMode.complete)
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  FloatingActionButton.small(
                    heroTag: 'zoom_in',
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
                    heroTag: 'zoom_out',
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

          // Info Panel
          const InfoPanel(),

          // Drawing Toolbar
          DrawingToolbar(onSave: () => _showSaveDialog()),
        ],
      ),
      floatingActionButton:
          !drawingState.isDrawing && drawingState.mode != DrawingMode.complete
          ? FloatingActionButton.extended(
              onPressed: () {
                ref.read(drawingStateProvider.notifier).startDrawing();
              },
              icon: const Icon(Icons.edit_location_alt),
              label: const Text('Mulai Gambar'),
            )
          : null,
    );
  }

  void _handleMapTap(point) {
    final drawingState = ref.read(drawingStateProvider);

    // If in drag mode and a vertex is selected, move it to tapped location
    if (drawingState.mode == DrawingMode.dragVertex &&
        drawingState.selectedVertexIndex != null) {
      ref
          .read(drawingStateProvider.notifier)
          .updateVertex(drawingState.selectedVertexIndex!, point);
      ref.read(drawingStateProvider.notifier).deselectVertex();

      TopNotification.showSuccess(context, 'Titik berhasil dipindahkan');
    }
    // Only add vertex if in add point mode
    else if (drawingState.mode == DrawingMode.addPoint) {
      ref.read(drawingStateProvider.notifier).addVertex(point);
    }
  }

  void _showSaveDialog() {
    final drawingState = ref.read(drawingStateProvider);

    if (!drawingState.canComplete) {
      TopNotification.showError(
        context,
        'Minimal 3 titik untuk menyimpan polygon',
      );
      return;
    }

    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Simpan Survey'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Survey',
                hintText: 'Contoh: Lahan Sawah A',
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Text('Statistik:', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            _InfoRow(
              label: 'Jumlah Titik',
              value: '${drawingState.vertices.length}',
            ),
            _InfoRow(
              label: 'Luas Area',
              value: '${drawingState.area.toStringAsFixed(2)} m²',
            ),
            _InfoRow(
              label: 'Keliling',
              value: '${drawingState.perimeter.toStringAsFixed(2)} m',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                TopNotification.showError(
                  context,
                  'Nama survey tidak boleh kosong',
                );
                return;
              }

              // Save to database
              try {
                final repository = ref.read(surveyRepositoryProvider);
                final surveyId = DateTime.now().millisecondsSinceEpoch
                    .toString();

                await repository.saveSurvey(
                  id: surveyId,
                  name: name,
                  vertices: drawingState.vertices,
                  areaSize: drawingState.area,
                  perimeter: drawingState.perimeter,
                );

                if (context.mounted) {
                  Navigator.pop(context); // Close dialog
                  ref.read(drawingStateProvider.notifier).cancelDrawing();

                  TopNotification.showSuccess(
                    context,
                    'Survey "$name" berhasil disimpan!',
                  );

                  // Navigate back
                  Navigator.pop(context);
                }
              } catch (e) {
                if (context.mounted) {
                  TopNotification.showError(context, 'Error: $e');
                }
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
