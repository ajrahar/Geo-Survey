import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_theme.dart';
import 'package:geosurvey/core/utils/tile_cache_manager.dart';
import 'package:geosurvey/features/projects/presentation/pages/project_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FMTC for offline tiles
  await TileCacheManager.initialize();

  runApp(const ProviderScope(child: GeoSurveyApp()));
}

class GeoSurveyApp extends StatelessWidget {
  const GeoSurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geo Survey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const ProjectListPage(),
    );
  }
}
