import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/features/map/presentation/pages/map_page.dart';
import 'package:geosurvey/features/map/presentation/pages/survey_list_page.dart';

class ProjectListPage extends ConsumerWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo Survey'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Riwayat Survey',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SurveyListPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.map_outlined,
                size: 100,
                color: AppColors.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang di Geo Survey',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Aplikasi pemetaan lahan offline untuk surveyor profesional',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPage()),
                  );
                },
                icon: const Icon(Icons.add_location_alt),
                label: const Text('Mulai Survey Baru'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurveyListPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.folder_open),
                label: const Text('Lihat Riwayat Survey'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
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
