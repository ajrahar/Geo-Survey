import 'package:latlong2/latlong.dart';

/// Map-specific constants for GeoSurvey Pro
class MapConstants {
  MapConstants._();

  // OpenStreetMap Tile Server
  static const String osmTileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String osmAttribution = '© OpenStreetMap contributors';

  // Alternative Tile Servers (for future use)
  static const String osmHotTileUrl =
      'https://tile-{s}.openstreetmap.fr/hot/{z}/{x}/{y}.png';

  // Map Configuration
  static const LatLng defaultCenter = LatLng(
    -2.5489,
    118.0149,
  ); // Indonesia center
  static const double defaultZoom = 5.0;
  static const double minZoom = 3.0;
  static const double maxZoom = 19.0;

  // Drawing Configuration
  static const double markerSize = 40.0;
  static const double selectedMarkerSize = 50.0;
  static const double polygonStrokeWidth = 3.0;
  static const double polygonFillOpacity = 0.25;

  // Tile Download Configuration
  static const int minDownloadZoom = 10;
  static const int maxDownloadZoom = 18;
  static const int defaultDownloadMinZoom = 12;
  static const int defaultDownloadMaxZoom = 16;

  // Performance
  static const int maxPolygonVertices = 1000;
  static const Duration mapInteractionDebounce = Duration(milliseconds: 100);
}
