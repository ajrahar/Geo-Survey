// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Geo Survey';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageTitle => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get projectListTitle => 'Geo Survey';

  @override
  String get startNewSurvey => 'Start New Survey';

  @override
  String get viewSurveyHistory => 'View Survey History';

  @override
  String get welcomeMessage => 'Welcome to Geo Survey';

  @override
  String get welcomeSubtitle =>
      'Offline land mapping app for professional surveyors';

  @override
  String get mapTitle => 'Survey Map';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get surveyName => 'Survey Name';

  @override
  String get surveyNameHint => 'Example: Rice Field A';

  @override
  String get surveyNameError => 'Survey name cannot be empty';

  @override
  String saveSuccess(String name) {
    return 'Survey \"$name\" saved successfully!';
  }

  @override
  String get statistics => 'Statistics';

  @override
  String get pointCount => 'Point Count';

  @override
  String get areaSize => 'Area Size';

  @override
  String get perimeter => 'Perimeter';

  @override
  String get importSurvey => 'Import KML/GeoJSON';

  @override
  String get importSuccess => 'Import successful';

  @override
  String importError(String error) {
    return 'Import failed: $error';
  }
}
