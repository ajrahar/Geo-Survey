/// Application-wide constants
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Geo Survey';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'geosurvey.db';
  static const int databaseVersion = 1;

  // Storage
  static const String tileStoreName = 'osm_tiles';
  static const int maxCachedTiles = 50000; // ~500MB at 10KB per tile

  // Units
  static const double squareMetersToHectares = 0.0001;
  static const double squareMetersToAcres = 0.000247105;

  // Validation
  static const int minPolygonPoints = 3;
  static const int maxProjectNameLength = 100;
  static const int maxSurveyNameLength = 100;
}
