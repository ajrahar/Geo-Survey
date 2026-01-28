import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:geosurvey/features/map/presentation/providers/drawing_state_provider.dart';
import 'package:geosurvey/core/localization/l10n/app_localizations.dart';

/// Floating info panel showing polygon statistics
class InfoPanel extends ConsumerWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState = ref.watch(drawingStateProvider);
    final l10n = AppLocalizations.of(context)!;

    if (!drawingState.isDrawing &&
        drawingState.mode != DrawingMode.complete &&
        drawingState.mode != DrawingMode.measure) {
      return Positioned(
        top: 16,
        left: 16,
        right: 72, // Modified to avoid overlap with Layer Selector
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.mapModeView,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.mapModeInstruction,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show statistics when drawing
    return Positioned(
      top: 16,
      left: 16,
      right: 72, // Modified to avoid overlap with Layer Selector
      child: Card(
        color: AppColors.primary,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.analytics_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    drawingState.mode == DrawingMode.measure
                        ? l10n.measureDistance
                        : l10n.polygonStatistics,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Vertices count (Common)
              _StatRow(
                icon: Icons.location_on,
                label: l10n.pointCount,
                value: '${drawingState.vertices.length}',
              ),

              const SizedBox(height: 8),

              // Measure Mode Stats
              if (drawingState.mode == DrawingMode.measure) ...[
                _StatRow(
                  icon: Icons.straighten,
                  label: l10n.totalDistance,
                  value: GeoCalculator.formatDistance(drawingState.perimeter),
                ),

                if (drawingState.vertices.length < 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l10n.measureInstruction,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],

              // Polygon Draw Mode Stats
              if (drawingState.mode != DrawingMode.measure &&
                  drawingState.vertices.length >= 3) ...[
                _StatRow(
                  icon: Icons.crop_square,
                  label: l10n.areaSize,
                  value: GeoCalculator.formatArea(drawingState.area),
                ),
                const SizedBox(height: 8),

                // Perimeter
                _StatRow(
                  icon: Icons.straighten,
                  label: l10n.perimeter,
                  value: GeoCalculator.formatDistance(drawingState.perimeter),
                ),
              ],

              // Hint for Polygon Draw
              if (drawingState.mode != DrawingMode.measure &&
                  drawingState.vertices.length < 3)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    l10n.polygonInstruction,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white70),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
