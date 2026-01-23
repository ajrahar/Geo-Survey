import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Reverse geocoding service using Nominatim (OpenStreetMap)
class GeocodingService {
  static const String _baseUrl = 'https://nominatim.openstreetmap.org';
  static const String _userAgent = 'GeoSurvey/1.0';

  /// Get address from coordinates using reverse geocoding
  static Future<String?> getAddressFromCoordinates(LatLng coordinates) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/reverse?format=json&lat=${coordinates.latitude}&lon=${coordinates.longitude}&zoom=18&addressdetails=1',
      );

      final response = await http.get(url, headers: {'User-Agent': _userAgent});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extract address components
        final address = data['address'] as Map<String, dynamic>?;
        if (address == null) return data['display_name'] as String?;

        // Build formatted address
        final parts = <String>[];

        // Road/Street
        if (address['road'] != null) {
          parts.add(address['road'] as String);
        }

        // Suburb/Village
        if (address['suburb'] != null) {
          parts.add(address['suburb'] as String);
        } else if (address['village'] != null) {
          parts.add(address['village'] as String);
        }

        // City
        if (address['city'] != null) {
          parts.add(address['city'] as String);
        } else if (address['town'] != null) {
          parts.add(address['town'] as String);
        } else if (address['municipality'] != null) {
          parts.add(address['municipality'] as String);
        }

        // State/Province
        if (address['state'] != null) {
          parts.add(address['state'] as String);
        }

        // Country
        if (address['country'] != null) {
          parts.add(address['country'] as String);
        }

        return parts.isNotEmpty
            ? parts.join(', ')
            : data['display_name'] as String?;
      }

      return null;
    } catch (e) {
      // Silently fail - geocoding is optional
      return null;
    }
  }

  /// Get address from center of polygon
  static Future<String?> getAddressFromPolygon(List<LatLng> vertices) async {
    if (vertices.isEmpty) return null;

    // Calculate center point
    double lat = 0;
    double lng = 0;

    for (final vertex in vertices) {
      lat += vertex.latitude;
      lng += vertex.longitude;
    }

    lat /= vertices.length;
    lng /= vertices.length;

    final center = LatLng(lat, lng);
    return getAddressFromCoordinates(center);
  }
}
