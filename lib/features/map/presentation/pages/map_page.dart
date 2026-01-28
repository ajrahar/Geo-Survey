import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/utils/tile_cache_manager.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/providers/drawing_state_provider.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:geosurvey/features/map/presentation/pages/tile_download_page.dart';
import 'package:geosurvey/features/map/presentation/widgets/polygon_layer_widget.dart';
import 'package:geosurvey/features/map/presentation/widgets/drawing_toolbar.dart';
import 'package:geosurvey/features/map/presentation/widgets/info_panel.dart';
import 'package:geosurvey/features/map/presentation/widgets/layer_selector_widget.dart';
import 'package:geosurvey/core/localization/l10n/app_localizations.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final MapController _mapController = MapController();
  MapLayerType _currentLayer = MapLayerType.normal;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final drawingState = ref.watch(drawingStateProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mapTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: l10n.downloadOfflineMap,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TileDownloadPage(),
                ),
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
              // Tile Layer
              TileLayer(
                urlTemplate: _getTileUrl(_currentLayer),
                userAgentPackageName: 'com.example.geosurvey',
                tileProvider: _currentLayer == MapLayerType.normal
                    ? TileCacheManager.getTileProvider()
                    : null, // Only cache normal OSM for now
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

          // Info Panel (Has right margin to avoid Layer Selector)
          const InfoPanel(),

          // Layer Selector
          if (!drawingState.isDrawing &&
              drawingState.mode != DrawingMode.complete)
            Positioned(
              top: 16,
              right: 16,
              child: LayerSelectorWidget(
                currentLayer: _currentLayer,
                onLayerChanged: (layer) {
                  setState(() {
                    _currentLayer = layer;
                  });
                },
              ),
            ),

          // Drawing Toolbar
          DrawingToolbar(onSave: () => _showSaveDialog(l10n)),
        ],
      ),
      floatingActionButton:
          !drawingState.isDrawing && drawingState.mode != DrawingMode.complete
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'measure',
                  onPressed: () {
                    ref.read(drawingStateProvider.notifier).startMeasurement();
                  },
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  icon: const Icon(Icons.straighten),
                  label: Text(l10n.measureDistance),
                ),
                const SizedBox(height: 12), // Reduced spacing slightly
                FloatingActionButton.extended(
                  heroTag: 'gps_track',
                  onPressed: () {
                    ref.read(drawingStateProvider.notifier).startGpsTracking();
                    TopNotification.showInfo(context, l10n.gpsWalkInstruction);
                  },
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.primary,
                  icon: const Icon(Icons.directions_walk),
                  label: Text(l10n.gpsRecord),
                ),
                const SizedBox(height: 12),
                FloatingActionButton.extended(
                  heroTag: 'draw',
                  onPressed: () {
                    ref.read(drawingStateProvider.notifier).startDrawing();
                  },
                  icon: const Icon(Icons.edit_location_alt),
                  label: Text(l10n.startDrawing),
                ),
              ],
            )
          : null,
    );
  }

  void _handleMapTap(point) {
    final drawingState = ref.read(drawingStateProvider);
    final l10n = AppLocalizations.of(context)!;

    // If in drag mode and a vertex is selected, move it to tapped location
    if (drawingState.mode == DrawingMode.dragVertex &&
        drawingState.selectedVertexIndex != null) {
      ref
          .read(drawingStateProvider.notifier)
          .updateVertex(drawingState.selectedVertexIndex!, point);
      ref.read(drawingStateProvider.notifier).deselectVertex();

      TopNotification.showSuccess(context, l10n.pointMoved);
    }
    // Only add vertex if in add point mode
    else if (drawingState.mode == DrawingMode.addPoint) {
      ref.read(drawingStateProvider.notifier).addVertex(point);
    }
  }

  void _showSaveDialog(AppLocalizations l10n) {
    final drawingState = ref.read(drawingStateProvider);

    if (!drawingState.canComplete) {
      TopNotification.showError(context, l10n.minPointsError);
      return;
    }

    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.saveSurveyTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: l10n.surveyName,
                hintText: l10n.surveyNameHint,
              ),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.statistics,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              label: l10n.pointCount,
              value: '${drawingState.vertices.length}',
            ),
            _InfoRow(
              label: l10n.areaSize,
              value: '${drawingState.area.toStringAsFixed(2)} m²',
            ),
            _InfoRow(
              label: l10n.perimeter,
              value: '${drawingState.perimeter.toStringAsFixed(2)} m',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = nameController.text.trim();
              if (name.isEmpty) {
                TopNotification.showError(context, l10n.surveyNameError);
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

                  TopNotification.showSuccess(context, l10n.saveSuccess(name));

                  // Navigate back
                  Navigator.pop(context);
                }
              } catch (e) {
                if (context.mounted) {
                  TopNotification.showError(context, 'Error: $e');
                }
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  String _getTileUrl(MapLayerType layer) {
    switch (layer) {
      case MapLayerType.normal:
        return MapConstants.osmTileUrl;
      case MapLayerType.satellite:
        // Esri World Imagery (free to use with attribution)
        return 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}';
      case MapLayerType.terrain:
        // OpenTopoMap
        return 'https://tile.opentopomap.org/{z}/{x}/{y}.png';
    }
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
