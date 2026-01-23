import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/theme/app_theme.dart';
import 'package:geosurvey/features/projects/presentation/pages/project_list_page.dart';

void main() {
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
      themeMode: ThemeMode.light,
      home: const ProjectListPage(),
    );
  }
}
