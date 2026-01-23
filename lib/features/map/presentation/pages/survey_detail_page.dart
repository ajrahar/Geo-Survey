import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/constants/map_constants.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class SurveyDetailPage extends ConsumerWidget {
  final String surveyId;

  const SurveyDetailPage({super.key, required this.surveyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(surveyRepositoryProvider);

    return FutureBuilder(
      future: repository.getSurveyById(surveyId),
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

        return Scaffold(
          appBar: AppBar(
            title: Text(survey.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                tooltip: 'Export GeoJSON',
                onPressed: () => _exportGeoJSON(context, survey, vertices),
              ),
            ],
          ),
          body: Column(
            children: [
              // Map View
              Expanded(
                flex: 2,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: vertices.isNotEmpty
                        ? vertices.first
                        : MapConstants.defaultCenter,
                    initialZoom: 15.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
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
                            borderStrokeWidth: MapConstants.polygonStrokeWidth,
                          ),
                        ],
                      ),
                    MarkerLayer(
                      markers: vertices.asMap().entries.map((entry) {
                        return Marker(
                          point: entry.value,
                          width: 30,
                          height: 30,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.markerColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
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

  void _exportGeoJSON(
    BuildContext context,
    dynamic survey,
    List<LatLng> vertices,
  ) {
    TopNotification.showInfo(
      context,
      'Fitur export GeoJSON akan segera tersedia',
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
