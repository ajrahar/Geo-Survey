import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/features/map/presentation/providers/drawing_state_provider.dart';

/// Floating toolbar for drawing controls
class DrawingToolbar extends ConsumerWidget {
  final VoidCallback onSave;

  const DrawingToolbar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState = ref.watch(drawingStateProvider);
    final notifier = ref.read(drawingStateProvider.notifier);

    if (!drawingState.isDrawing && drawingState.mode != DrawingMode.complete) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Mode indicator
              Row(
                children: [
                  Icon(
                    _getModeIcon(drawingState.mode),
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getModeText(drawingState.mode),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  Text(
                    '${drawingState.vertices.length} titik',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Add Point Mode
                  if (drawingState.mode != DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.add_location_alt,
                      label: 'Tambah',
                      isActive: drawingState.mode == DrawingMode.addPoint,
                      onPressed: () => notifier.enableAddPointMode(),
                    ),

                  // Drag Mode
                  if (drawingState.hasVertices &&
                      drawingState.mode != DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.open_with,
                      label: 'Geser',
                      isActive: drawingState.mode == DrawingMode.dragVertex,
                      onPressed: () => notifier.enableDragMode(),
                    ),

                  // Undo
                  if (drawingState.hasVertices &&
                      drawingState.mode != DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.undo,
                      label: 'Undo',
                      onPressed: drawingState.vertices.isNotEmpty
                          ? () => notifier.removeLastVertex()
                          : null,
                    ),

                  // Clear
                  if (drawingState.hasVertices &&
                      drawingState.mode != DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.delete_outline,
                      label: 'Hapus',
                      color: AppColors.error,
                      onPressed: () =>
                          _showClearConfirmation(context, notifier),
                    ),

                  // Complete
                  if (drawingState.canComplete &&
                      drawingState.mode != DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.check_circle_outline,
                      label: 'Selesai',
                      color: AppColors.success,
                      onPressed: () => notifier.completePolygon(),
                    ),

                  // Stop Tracking (only in gpsTrack mode)
                  if (drawingState.mode == DrawingMode.gpsTrack)
                    _ToolbarButton(
                      icon: Icons.stop_circle,
                      label: 'Stop Record',
                      color: AppColors.error,
                      onPressed: () => notifier.stopGpsTracking(),
                    ),

                  // Save (when completed)
                  if (drawingState.mode == DrawingMode.complete)
                    _ToolbarButton(
                      icon: Icons.save,
                      label: 'Simpan',
                      color: AppColors.success,
                      onPressed: onSave,
                    ),

                  // Cancel
                  _ToolbarButton(
                    icon: Icons.close,
                    label: 'Batal',
                    color: AppColors.error,
                    onPressed: () => _showCancelConfirmation(context, notifier),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getModeIcon(DrawingMode mode) {
    switch (mode) {
      case DrawingMode.addPoint:
        return Icons.add_location_alt;
      case DrawingMode.dragVertex:
        return Icons.open_with;
      case DrawingMode.complete:
        return Icons.check_circle;
      case DrawingMode.measure:
        return Icons.straighten;
      case DrawingMode.gpsTrack:
        return Icons.directions_walk;
      default:
        return Icons.edit_location_alt;
    }
  }

  String _getModeText(DrawingMode mode) {
    switch (mode) {
      case DrawingMode.addPoint:
        return 'Mode: Tambah Titik';
      case DrawingMode.dragVertex:
        return 'Mode: Geser Titik';
      case DrawingMode.complete:
        return 'Polygon Selesai';
      case DrawingMode.measure:
        return 'Mode: Ukur Jarak';
      case DrawingMode.gpsTrack:
        return 'Merekam Posisi...';
      default:
        return 'Mode: Idle';
    }
  }

  void _showClearConfirmation(
    BuildContext context,
    DrawingStateNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Titik?'),
        content: const Text('Semua titik yang sudah digambar akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              notifier.clearPolygon();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation(
    BuildContext context,
    DrawingStateNotifier notifier,
  ) {
    // If just measuring, no need for confirmation dialog if no points
    // But for consistency let's just cancel
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan?'),
        content: const Text('Semua progress akan hilang.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              notifier.cancelDrawing();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
  }
}

/// Individual toolbar button
class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isActive;
  final Color? color;

  const _ToolbarButton({
    required this.icon,
    required this.label,
    this.onPressed,
    this.isActive = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor =
        color ?? (isActive ? AppColors.primary : AppColors.textSecondary);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          color: buttonColor,
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: isActive
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: buttonColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
