import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/features/map/presentation/providers/drawing_state_provider.dart';

/// Widget that renders the polygon and markers on the map
class PolygonLayerWidget extends ConsumerWidget {
  final MapController mapController;

  const PolygonLayerWidget({super.key, required this.mapController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState = ref.watch(drawingStateProvider);
    final vertices = drawingState.vertices;

    if (vertices.isEmpty) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        if (vertices.length >= 2)
          PolygonLayer(
            polygons: [
              Polygon(
                points: vertices,
                color: AppColors.polygonFill,
                borderColor: AppColors.polygonStroke,
                borderStrokeWidth: MapConstants.polygonStrokeWidth,
              ),
            ],
          ),

        // Marker Layer for vertices
        MarkerLayer(markers: _buildMarkers(vertices, drawingState, ref)),
      ],
    );
  }

  List<Marker> _buildMarkers(
    List<LatLng> vertices,
    DrawingState drawingState,
    WidgetRef ref,
  ) {
    return vertices.asMap().entries.map((entry) {
      final index = entry.key;
      final point = entry.value;
      final isSelected = drawingState.selectedVertexIndex == index;
      final isDragMode = drawingState.mode == DrawingMode.dragVertex;

      return Marker(
        point: point,
        width: isSelected
            ? MapConstants.selectedMarkerSize
            : MapConstants.markerSize,
        height: isSelected
            ? MapConstants.selectedMarkerSize
            : MapConstants.markerSize,
        child: GestureDetector(
          onTap: () {
            if (isDragMode) {
              ref.read(drawingStateProvider.notifier).selectVertex(index);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.selectedMarker
                  : AppColors.markerColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}
