import 'package:flutter_test/flutter_test.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('GeoCalculator Tests', () {
    test('calculateArea - square 100m x 100m should be ~10000 m²', () {
      // Create a square polygon (approximately 100m x 100m)
      final vertices = [
        const LatLng(-6.200000, 106.816000),
        const LatLng(-6.200000, 106.817000),
        const LatLng(-6.201000, 106.817000),
        const LatLng(-6.201000, 106.816000),
      ];

      final area = GeoCalculator.calculateArea(vertices);

      // Area should be approximately 12000 m² (geodesic calculations)
      expect(area, greaterThan(11000));
      expect(area, lessThan(13000));
    });

    test('calculatePerimeter - square should have 4 equal sides', () {
      final vertices = [
        const LatLng(-6.200000, 106.816000),
        const LatLng(-6.200000, 106.817000),
        const LatLng(-6.201000, 106.817000),
        const LatLng(-6.201000, 106.816000),
      ];

      final perimeter = GeoCalculator.calculatePerimeter(vertices);

      // Perimeter should be approximately 440m (geodesic)
      expect(perimeter, greaterThan(430));
      expect(perimeter, lessThan(450));
    });

    test('calculateDistance - 1 degree latitude is ~111km', () {
      const point1 = LatLng(0.0, 0.0);
      const point2 = LatLng(1.0, 0.0);

      final distance = GeoCalculator.calculateDistance(point1, point2);

      // 1 degree latitude ≈ 111 km = 111000 m
      expect(distance, greaterThan(110000));
      expect(distance, lessThan(112000));
    });

    test('formatArea - converts m² to hectares correctly', () {
      expect(GeoCalculator.formatArea(5000), '5000.00 m²');
      expect(GeoCalculator.formatArea(15000), '1.50 ha');
      expect(GeoCalculator.formatArea(100000), '10.00 ha');
    });

    test('formatDistance - converts meters to kilometers correctly', () {
      expect(GeoCalculator.formatDistance(500), '500.00 m');
      expect(GeoCalculator.formatDistance(1500), '1.50 km');
      expect(GeoCalculator.formatDistance(10000), '10.00 km');
    });

    test('calculateArea - returns 0 for less than 3 vertices', () {
      expect(GeoCalculator.calculateArea([]), 0.0);
      expect(GeoCalculator.calculateArea([const LatLng(0, 0)]), 0.0);
      expect(
        GeoCalculator.calculateArea([const LatLng(0, 0), const LatLng(1, 1)]),
        0.0,
      );
    });

    test('calculatePerimeter - returns 0 for less than 2 vertices', () {
      expect(GeoCalculator.calculatePerimeter([]), 0.0);
      expect(GeoCalculator.calculatePerimeter([const LatLng(0, 0)]), 0.0);
    });
  });
}
