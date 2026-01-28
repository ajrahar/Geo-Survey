import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geosurvey/core/localization/locale_provider.dart';
import 'package:geosurvey/core/theme/app_theme.dart';
import 'package:geosurvey/core/utils/tile_cache_manager.dart';
import 'package:geosurvey/features/projects/presentation/pages/project_list_page.dart';
import 'package:geosurvey/core/localization/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize FMTC for offline tiles
  await TileCacheManager.initialize();

  runApp(const ProviderScope(child: GeoSurveyApp()));
}

class GeoSurveyApp extends ConsumerWidget {
  const GeoSurveyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(localeControllerProvider);

    return MaterialApp(
      title: 'Geo Survey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: localeState.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('id'), // Indonesian
      ],
      home: const ProjectListPage(),
    );
  }
}
