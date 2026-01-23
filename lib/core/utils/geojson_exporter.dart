import 'dart:convert';
import 'package:latlong2/latlong.dart';

/// GeoJSON serialization utilities for survey data
class GeoJsonExporter {
  /// Convert survey to GeoJSON FeatureCollection
  static Map<String, dynamic> surveyToGeoJson({
    required String id,
    required String name,
    required List<LatLng> vertices,
    required double areaSize,
    required double perimeter,
    required DateTime createdAt,
    String address = '',
  }) {
    // Create coordinates array (GeoJSON uses [lng, lat] order, not [lat, lng])
    final coordinates = vertices.map((v) => [v.longitude, v.latitude]).toList();

    // Close the polygon by adding first point at the end
    if (coordinates.isNotEmpty) {
      coordinates.add(coordinates.first);
    }

    return {
      'type': 'FeatureCollection',
      'features': [
        {
          'type': 'Feature',
          'id': id,
          'geometry': {
            'type': 'Polygon',
            'coordinates': [coordinates], // Polygon requires array of rings
          },
          'properties': {
            'name': name,
            'area_m2': areaSize,
            'perimeter_m': perimeter,
            'area_ha': areaSize / 10000,
            'created_at': createdAt.toIso8601String(),
            'address': address,
            'vertex_count': vertices.length,
          },
        },
      ],
    };
  }

  /// Convert GeoJSON to formatted JSON string
  static String toJsonString(
    Map<String, dynamic> geoJson, {
    bool pretty = true,
  }) {
    if (pretty) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(geoJson);
    }
    return jsonEncode(geoJson);
  }

  /// Generate filename for export
  static String generateFilename(String surveyName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final safeName = surveyName
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');
    return 'survey_${safeName}_$timestamp.geojson';
  }
}
