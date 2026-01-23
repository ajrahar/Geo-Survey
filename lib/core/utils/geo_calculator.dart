import 'package:latlong2/latlong.dart';
import 'package:turf/turf.dart' as turf;

/// Utility class for geospatial calculations
/// Uses Turf.js for accurate geodesic calculations
class GeoCalculator {
  GeoCalculator._();

  /// Calculate area of a polygon in square meters
  ///
  /// Uses geodesic calculation for accuracy on Earth's curved surface
  /// Requires at least 3 points to form a valid polygon
  ///
  /// Returns 0 if polygon is invalid
  static double calculateArea(List<LatLng> points) {
    if (points.length < 3) return 0.0;

    try {
      // Convert LatLng to Turf coordinates [lng, lat]
      final coordinates = points
          .map((p) => turf.Position.of([p.longitude, p.latitude]))
          .toList();

      // Close the polygon by adding first point at the end
      if (coordinates.first != coordinates.last) {
        coordinates.add(coordinates.first);
      }

      // Create Turf polygon
      final polygon = turf.Polygon(coordinates: [coordinates]);
      final feature = turf.Feature(geometry: polygon);

      // Calculate area in square meters
      final areaInSquareMeters = turf.area(feature);

      return (areaInSquareMeters ?? 0).toDouble();
    } catch (e) {
      // Return 0 if calculation fails
      return 0.0;
    }
  }

  /// Calculate perimeter of a polygon in meters
  ///
  /// Uses geodesic calculation for accuracy
  /// Returns 0 if polygon is invalid
  static double calculatePerimeter(List<LatLng> points) {
    if (points.length < 2) return 0.0;

    try {
      // Convert to Turf coordinates
      final coordinates = points
          .map((p) => turf.Position.of([p.longitude, p.latitude]))
          .toList();

      // Close the polygon
      if (coordinates.first != coordinates.last) {
        coordinates.add(coordinates.first);
      }

      // Create LineString for perimeter calculation
      final lineString = turf.LineString(coordinates: coordinates);
      final feature = turf.Feature(geometry: lineString);

      // Calculate length in meters
      final lengthInMeters = turf.length(feature, turf.Unit.meters);

      return lengthInMeters.toDouble();
    } catch (e) {
      return 0.0;
    }
  }

  /// Convert square meters to hectares
  static double toHectares(double squareMeters) {
    return squareMeters * 0.0001;
  }

  /// Convert square meters to acres
  static double toAcres(double squareMeters) {
    return squareMeters * 0.000247105;
  }

  /// Format area with appropriate unit
  ///
  /// Returns hectares for large areas (>= 10,000 m²)
  /// Returns square meters for smaller areas
  static String formatArea(double squareMeters) {
    if (squareMeters >= 10000) {
      final hectares = toHectares(squareMeters);
      return '${hectares.toStringAsFixed(2)} ha';
    } else {
      return '${squareMeters.toStringAsFixed(2)} m²';
    }
  }

  /// Format distance/perimeter in meters or kilometers
  static String formatDistance(double meters) {
    if (meters >= 1000) {
      final kilometers = meters / 1000;
      return '${kilometers.toStringAsFixed(2)} km';
    } else {
      return '${meters.toStringAsFixed(2)} m';
    }
  }

  /// Calculate distance between two points in meters
  static double calculateDistance(LatLng point1, LatLng point2) {
    try {
      final from = turf.Point(
        coordinates: turf.Position.of([point1.longitude, point1.latitude]),
      );
      final to = turf.Point(
        coordinates: turf.Position.of([point2.longitude, point2.latitude]),
      );

      return turf.distance(from, to, turf.Unit.meters).toDouble();
    } catch (e) {
      return 0.0;
    }
  }

  /// Check if a polygon is valid (no self-intersections)
  ///
  /// Note: Basic validation, doesn't check for complex self-intersections
  static bool isValidPolygon(List<LatLng> points) {
    if (points.length < 3) return false;

    // Check for duplicate consecutive points
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].latitude == points[i + 1].latitude &&
          points[i].longitude == points[i + 1].longitude) {
        return false;
      }
    }

    return true;
  }
}
