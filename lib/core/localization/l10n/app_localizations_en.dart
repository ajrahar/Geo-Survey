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

  @override
  String get mapModeView => 'View Mode';

  @override
  String get mapModeInstruction => 'Tap \"Start Drawing\" to create a polygon';

  @override
  String get measureDistance => 'Measure Distance';

  @override
  String get polygonStatistics => 'Polygon Statistics';

  @override
  String get totalDistance => 'Total Distance';

  @override
  String get measureInstruction => 'Tap 2 points to measure distance';

  @override
  String get polygonInstruction => 'Minimum 3 points to create a polygon';

  @override
  String get downloadOfflineMap => 'Download Offline Map';

  @override
  String get startDrawing => 'Start Drawing';

  @override
  String get gpsRecord => 'GPS Record';

  @override
  String get gpsWalkInstruction => 'Walk to record the area';

  @override
  String get saveSurvey => 'Save Survey';

  @override
  String get saveSurveyTitle => 'Save Survey';

  @override
  String get pointMoved => 'Point moved successfully';

  @override
  String get minPointsError => 'Minimum 3 points required to save polygon';

  @override
  String get surveyDetail => 'Survey Detail';

  @override
  String get dateCreated => 'Date Created';

  @override
  String get address => 'Address';

  @override
  String get fetchAddress => 'Tap to fetch address from coordinates';

  @override
  String get fetchingAddress => 'Fetching address...';

  @override
  String get photoDocumentation => 'Photo Documentation';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get noPhotos => 'No documentation photos yet';

  @override
  String get coordinates => 'Coordinates';

  @override
  String get exportGeoJson => 'Export GeoJSON';

  @override
  String get exportPng => 'Export PNG Image';

  @override
  String get exportPdf => 'Export PDF Report';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get photoAdded => 'Photo added successfully';

  @override
  String get photoDeleted => 'Photo deleted';

  @override
  String deletePhotoError(String error) {
    return 'Failed to delete photo: $error';
  }

  @override
  String addPhotoError(String error) {
    return 'Failed to add photo: $error';
  }

  @override
  String get surveyHistoryTitle => 'Survey History';

  @override
  String get noSurveys => 'No surveys yet';

  @override
  String get createSurveyInstruction => 'Tap + to create a new survey';

  @override
  String get deleteSurveyTitle => 'Delete Survey?';

  @override
  String deleteSurveyContent(String name) {
    return 'Survey \"$name\" will be permanently deleted.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get deleteSuccess => 'Survey deleted successfully';

  @override
  String get cameraOption => 'Take Photo (Camera)';

  @override
  String get galleryOption => 'Choose from Gallery';

  @override
  String get exportGeoJsonSubtitle => 'Standard GIS format';

  @override
  String get exportPngSubtitle => 'Map screenshot as image';

  @override
  String get exportPdfSubtitle => 'Complete report with statistics';

  @override
  String get capturingScreenshot => 'Capturing screenshot...';

  @override
  String get generatingPdf => 'Generating PDF report...';

  @override
  String exportSuccess(String type) {
    return '$type exported successfully!';
  }

  @override
  String exportError(String type, String error) {
    return 'Failed to export $type: $error';
  }

  @override
  String get addressFromCoords => 'Address (from coords)';

  @override
  String pointCountValue(int count) {
    return '$count points';
  }
}
