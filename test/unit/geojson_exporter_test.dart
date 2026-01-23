import 'package:flutter_test/flutter_test.dart';
import 'package:geosurvey/core/utils/geojson_exporter.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('GeoJsonExporter Tests', () {
    test('surveyToGeoJson - creates valid GeoJSON structure', () {
      final vertices = [
        const LatLng(-6.200, 106.816),
        const LatLng(-6.200, 106.817),
        const LatLng(-6.201, 106.817),
        const LatLng(-6.201, 106.816),
      ];

      final geoJson = GeoJsonExporter.surveyToGeoJson(
        id: 'test-123',
        name: 'Test Survey',
        vertices: vertices,
        areaSize: 10000.0,
        perimeter: 400.0,
        createdAt: DateTime(2026, 1, 23),
        address: 'Test Address',
      );

      // Verify structure
      expect(geoJson['type'], 'FeatureCollection');
      expect(geoJson['features'], isA<List>());
      expect(geoJson['features'].length, 1);

      final feature = geoJson['features'][0];
      expect(feature['type'], 'Feature');
      expect(feature['id'], 'test-123');
      expect(feature['geometry']['type'], 'Polygon');
      expect(feature['properties']['name'], 'Test Survey');
      expect(feature['properties']['area_m2'], 10000.0);
      expect(feature['properties']['perimeter_m'], 400.0);
      expect(feature['properties']['area_ha'], 1.0);
      expect(feature['properties']['address'], 'Test Address');
    });

    test('surveyToGeoJson - coordinates are in [lng, lat] order', () {
      final vertices = [
        const LatLng(-6.200, 106.816),
        const LatLng(-6.201, 106.817),
      ];

      final geoJson = GeoJsonExporter.surveyToGeoJson(
        id: 'test',
        name: 'Test',
        vertices: vertices,
        areaSize: 0,
        perimeter: 0,
        createdAt: DateTime.now(),
      );

      final coordinates = geoJson['features'][0]['geometry']['coordinates'][0];

      // First coordinate should be [lng, lat]
      expect(coordinates[0][0], 106.816); // longitude
      expect(coordinates[0][1], -6.200); // latitude
    });

    test('surveyToGeoJson - polygon is closed (first point = last point)', () {
      final vertices = [
        const LatLng(-6.200, 106.816),
        const LatLng(-6.200, 106.817),
        const LatLng(-6.201, 106.817),
      ];

      final geoJson = GeoJsonExporter.surveyToGeoJson(
        id: 'test',
        name: 'Test',
        vertices: vertices,
        areaSize: 0,
        perimeter: 0,
        createdAt: DateTime.now(),
      );

      final coordinates = geoJson['features'][0]['geometry']['coordinates'][0];

      // First and last coordinates should be the same
      expect(coordinates.first, coordinates.last);
      expect(coordinates.length, vertices.length + 1); // +1 for closing point
    });

    test('toJsonString - creates formatted JSON', () {
      final geoJson = {'type': 'FeatureCollection', 'features': []};

      final jsonString = GeoJsonExporter.toJsonString(geoJson, pretty: true);

      expect(jsonString, contains('\n'));
      expect(jsonString, contains('  '));
      expect(jsonString, contains('"type": "FeatureCollection"'));
    });

    test('toJsonString - creates compact JSON when pretty=false', () {
      final geoJson = {'type': 'FeatureCollection', 'features': []};

      final jsonString = GeoJsonExporter.toJsonString(geoJson, pretty: false);

      expect(jsonString, isNot(contains('\n  ')));
      expect(jsonString, '{"type":"FeatureCollection","features":[]}');
    });

    test('generateFilename - creates valid filename', () {
      final filename = GeoJsonExporter.generateFilename('Test Survey');

      expect(filename, startsWith('survey_Test_Survey_'));
      expect(filename, endsWith('.geojson'));
      expect(filename, isNot(contains(' ')));
    });

    test('generateFilename - sanitizes special characters', () {
      final filename = GeoJsonExporter.generateFilename('Test/Survey:123');

      expect(filename, isNot(contains('/')));
      expect(filename, isNot(contains(':')));
      expect(filename, contains('TestSurvey123'));
    });
  });
}
