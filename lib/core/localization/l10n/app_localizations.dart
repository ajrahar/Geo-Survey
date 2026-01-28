import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Geo Survey'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @projectListTitle.
  ///
  /// In en, this message translates to:
  /// **'Geo Survey'**
  String get projectListTitle;

  /// No description provided for @startNewSurvey.
  ///
  /// In en, this message translates to:
  /// **'Start New Survey'**
  String get startNewSurvey;

  /// No description provided for @viewSurveyHistory.
  ///
  /// In en, this message translates to:
  /// **'View Survey History'**
  String get viewSurveyHistory;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Geo Survey'**
  String get welcomeMessage;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Offline land mapping app for professional surveyors'**
  String get welcomeSubtitle;

  /// No description provided for @mapTitle.
  ///
  /// In en, this message translates to:
  /// **'Survey Map'**
  String get mapTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @surveyName.
  ///
  /// In en, this message translates to:
  /// **'Survey Name'**
  String get surveyName;

  /// No description provided for @surveyNameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Rice Field A'**
  String get surveyNameHint;

  /// No description provided for @surveyNameError.
  ///
  /// In en, this message translates to:
  /// **'Survey name cannot be empty'**
  String get surveyNameError;

  /// No description provided for @saveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Survey \"{name}\" saved successfully!'**
  String saveSuccess(String name);

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @pointCount.
  ///
  /// In en, this message translates to:
  /// **'Point Count'**
  String get pointCount;

  /// No description provided for @areaSize.
  ///
  /// In en, this message translates to:
  /// **'Area Size'**
  String get areaSize;

  /// No description provided for @perimeter.
  ///
  /// In en, this message translates to:
  /// **'Perimeter'**
  String get perimeter;

  /// No description provided for @importSurvey.
  ///
  /// In en, this message translates to:
  /// **'Import KML/GeoJSON'**
  String get importSurvey;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Import successful'**
  String get importSuccess;

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importError(String error);

  /// No description provided for @mapModeView.
  ///
  /// In en, this message translates to:
  /// **'View Mode'**
  String get mapModeView;

  /// No description provided for @mapModeInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Start Drawing\" to create a polygon'**
  String get mapModeInstruction;

  /// No description provided for @measureDistance.
  ///
  /// In en, this message translates to:
  /// **'Measure Distance'**
  String get measureDistance;

  /// No description provided for @polygonStatistics.
  ///
  /// In en, this message translates to:
  /// **'Polygon Statistics'**
  String get polygonStatistics;

  /// No description provided for @totalDistance.
  ///
  /// In en, this message translates to:
  /// **'Total Distance'**
  String get totalDistance;

  /// No description provided for @measureInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap 2 points to measure distance'**
  String get measureInstruction;

  /// No description provided for @polygonInstruction.
  ///
  /// In en, this message translates to:
  /// **'Minimum 3 points to create a polygon'**
  String get polygonInstruction;

  /// No description provided for @downloadOfflineMap.
  ///
  /// In en, this message translates to:
  /// **'Download Offline Map'**
  String get downloadOfflineMap;

  /// No description provided for @startDrawing.
  ///
  /// In en, this message translates to:
  /// **'Start Drawing'**
  String get startDrawing;

  /// No description provided for @gpsRecord.
  ///
  /// In en, this message translates to:
  /// **'GPS Record'**
  String get gpsRecord;

  /// No description provided for @gpsWalkInstruction.
  ///
  /// In en, this message translates to:
  /// **'Walk to record the area'**
  String get gpsWalkInstruction;

  /// No description provided for @saveSurvey.
  ///
  /// In en, this message translates to:
  /// **'Save Survey'**
  String get saveSurvey;

  /// No description provided for @saveSurveyTitle.
  ///
  /// In en, this message translates to:
  /// **'Save Survey'**
  String get saveSurveyTitle;

  /// No description provided for @pointMoved.
  ///
  /// In en, this message translates to:
  /// **'Point moved successfully'**
  String get pointMoved;

  /// No description provided for @minPointsError.
  ///
  /// In en, this message translates to:
  /// **'Minimum 3 points required to save polygon'**
  String get minPointsError;

  /// No description provided for @surveyDetail.
  ///
  /// In en, this message translates to:
  /// **'Survey Detail'**
  String get surveyDetail;

  /// No description provided for @dateCreated.
  ///
  /// In en, this message translates to:
  /// **'Date Created'**
  String get dateCreated;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @fetchAddress.
  ///
  /// In en, this message translates to:
  /// **'Tap to fetch address from coordinates'**
  String get fetchAddress;

  /// No description provided for @fetchingAddress.
  ///
  /// In en, this message translates to:
  /// **'Fetching address...'**
  String get fetchingAddress;

  /// No description provided for @photoDocumentation.
  ///
  /// In en, this message translates to:
  /// **'Photo Documentation'**
  String get photoDocumentation;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @noPhotos.
  ///
  /// In en, this message translates to:
  /// **'No documentation photos yet'**
  String get noPhotos;

  /// No description provided for @coordinates.
  ///
  /// In en, this message translates to:
  /// **'Coordinates'**
  String get coordinates;

  /// No description provided for @exportGeoJson.
  ///
  /// In en, this message translates to:
  /// **'Export GeoJSON'**
  String get exportGeoJson;

  /// No description provided for @exportPng.
  ///
  /// In en, this message translates to:
  /// **'Export PNG Image'**
  String get exportPng;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF Report'**
  String get exportPdf;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @photoAdded.
  ///
  /// In en, this message translates to:
  /// **'Photo added successfully'**
  String get photoAdded;

  /// No description provided for @photoDeleted.
  ///
  /// In en, this message translates to:
  /// **'Photo deleted'**
  String get photoDeleted;

  /// No description provided for @deletePhotoError.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete photo: {error}'**
  String deletePhotoError(String error);

  /// No description provided for @addPhotoError.
  ///
  /// In en, this message translates to:
  /// **'Failed to add photo: {error}'**
  String addPhotoError(String error);

  /// No description provided for @surveyHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Survey History'**
  String get surveyHistoryTitle;

  /// No description provided for @noSurveys.
  ///
  /// In en, this message translates to:
  /// **'No surveys yet'**
  String get noSurveys;

  /// No description provided for @createSurveyInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create a new survey'**
  String get createSurveyInstruction;

  /// No description provided for @deleteSurveyTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Survey?'**
  String get deleteSurveyTitle;

  /// No description provided for @deleteSurveyContent.
  ///
  /// In en, this message translates to:
  /// **'Survey \"{name}\" will be permanently deleted.'**
  String deleteSurveyContent(String name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Survey deleted successfully'**
  String get deleteSuccess;

  /// No description provided for @cameraOption.
  ///
  /// In en, this message translates to:
  /// **'Take Photo (Camera)'**
  String get cameraOption;

  /// No description provided for @galleryOption.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get galleryOption;

  /// No description provided for @exportGeoJsonSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Standard GIS format'**
  String get exportGeoJsonSubtitle;

  /// No description provided for @exportPngSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Map screenshot as image'**
  String get exportPngSubtitle;

  /// No description provided for @exportPdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete report with statistics'**
  String get exportPdfSubtitle;

  /// No description provided for @capturingScreenshot.
  ///
  /// In en, this message translates to:
  /// **'Capturing screenshot...'**
  String get capturingScreenshot;

  /// No description provided for @generatingPdf.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF report...'**
  String get generatingPdf;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'{type} exported successfully!'**
  String exportSuccess(String type);

  /// No description provided for @exportError.
  ///
  /// In en, this message translates to:
  /// **'Failed to export {type}: {error}'**
  String exportError(String type, String error);

  /// No description provided for @addressFromCoords.
  ///
  /// In en, this message translates to:
  /// **'Address (from coords)'**
  String get addressFromCoords;

  /// No description provided for @pointCountValue.
  ///
  /// In en, this message translates to:
  /// **'{count} points'**
  String pointCountValue(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
