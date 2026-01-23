import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/database/app_database.dart';
import 'package:geosurvey/features/map/data/repositories/survey_repository.dart';

/// Provider for AppDatabase singleton
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Provider for SurveyRepository
final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return SurveyRepository(database);
});

/// Provider for survey list (auto-refresh)
final surveyListProvider = StreamProvider<List<Survey>>((ref) {
  final database = ref.watch(appDatabaseProvider);

  // Watch surveys table for changes
  return database.select(database.surveys).watch();
});
