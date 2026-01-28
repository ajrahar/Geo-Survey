import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_colors.dart';
import 'package:geosurvey/features/map/presentation/pages/map_page.dart';
import 'package:geosurvey/features/map/presentation/pages/survey_list_page.dart';
import 'package:geosurvey/features/settings/presentation/pages/settings_page.dart';
import 'package:geosurvey/core/localization/l10n/app_localizations.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:geosurvey/core/widgets/top_notification.dart';
import 'package:geosurvey/features/map/presentation/pages/survey_detail_page.dart';
import 'package:geosurvey/features/map/presentation/providers/database_providers.dart';
import 'package:geosurvey/features/projects/services/geo_import_service.dart';

class ProjectListPage extends ConsumerWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: l10n.viewSurveyHistory,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SurveyListPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTitle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
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
                l10n.welcomeMessage,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                l10n.welcomeSubtitle,
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
                label: Text(l10n.startNewSurvey),
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
                label: Text(l10n.viewSurveyHistory),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => _importSurvey(context, ref, l10n),
                icon: const Icon(Icons.file_upload),
                label: Text(l10n.importSurvey),
                style: TextButton.styleFrom(
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

  Future<void> _importSurvey(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final importedData = await GeoImportService.pickAndImportFile();
    if (importedData == null) return;

    try {
      final repository = ref.read(surveyRepositoryProvider);
      final surveyId = DateTime.now().millisecondsSinceEpoch.toString();

      final area = GeoCalculator.calculateArea(importedData.vertices);
      final perimeter = GeoCalculator.calculatePerimeter(importedData.vertices);

      await repository.saveSurvey(
        id: surveyId,
        name: importedData.name,
        vertices: importedData.vertices,
        areaSize: area,
        perimeter: perimeter,
      );

      if (context.mounted) {
        TopNotification.showSuccess(context, l10n.importSuccess);

        // Navigate to details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SurveyDetailPage(surveyId: surveyId),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        TopNotification.showError(context, l10n.importError(e.toString()));
      }
    }
  }
}
