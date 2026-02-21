import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart';

class ImportedSurveyData {
  final String name;
  final List<LatLng> vertices;

  ImportedSurveyData({required this.name, required this.vertices});
}

class GeoImportService {
  /// Pick and parse a KML or GeoJSON file
  static Future<ImportedSurveyData?> pickAndImportFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'geojson', 'kml'],
      );

      if (result == null || result.files.isEmpty) return null;

      final path = result.files.single.path;
      if (path == null || path.isEmpty) return null;

      final file = File(path);
      final content = await file.readAsString();
      final extension = result.files.single.extension?.toLowerCase();
      final filename = result.files.single.name;

      if (extension == 'kml') {
        return _parseKml(content, filename);
      } else if (extension == 'json' || extension == 'geojson') {
        return _parseGeoJson(content, filename);
      }

      return null;
    } catch (e) {
      debugPrint('Error importing file: $e');
      return null;
    }
  }

  static ImportedSurveyData? _parseGeoJson(String content, String filename) {
    try {
      final data = jsonDecode(content);

      // Look for FeatureCollection or Feature
      List<dynamic> features = [];
      if (data['type'] == 'FeatureCollection') {
        features = data['features'] is List ? data['features'] as List : [];
      } else if (data['type'] == 'Feature') {
        features = [data];
      }

      // Find first Polygon
      for (final feature in features) {
        final geometry = feature['geometry'];
        if (geometry == null) continue;

        if (geometry['type'] == 'Polygon') {
          final coordinates = geometry['coordinates'][0] as List;
          final vertices = coordinates.map((coord) {
            return LatLng(coord[1].toDouble(), coord[0].toDouble());
          }).toList();

          // Remove last point if it duplicates the first (closed loop)
          if (vertices.length > 2 && vertices.first == vertices.last) {
            vertices.removeLast();
          }

          String name = feature['properties']?['name'] ?? filename;
          return ImportedSurveyData(name: name, vertices: vertices);
        }
      }
      return null;
    } catch (e) {
      debugPrint('GeoJSON parse error: $e');
      return null;
    }
  }

  static ImportedSurveyData? _parseKml(String content, String filename) {
    try {
      final document = XmlDocument.parse(content);

      // Find first Placemark with Polygon
      final placemarks = document.findAllElements('Placemark');

      for (final placemark in placemarks) {
        final polygon = placemark.findElements('Polygon').firstOrNull;
        if (polygon != null) {
          final outerBoundary = polygon
              .findElements('outerBoundaryIs')
              .firstOrNull;
          final linearRing = outerBoundary
              ?.findElements('LinearRing')
              .firstOrNull;
          final coordinatesNode = linearRing
              ?.findElements('coordinates')
              .firstOrNull;

          if (coordinatesNode != null) {
            final coordsText = coordinatesNode.innerText.trim();
            final coordsList = coordsText.split(RegExp(r'\s+'));

            final vertices = <LatLng>[];
            for (final coordStr in coordsList) {
              final parts = coordStr.split(',');
              if (parts.length >= 2) {
                final lng = double.tryParse(parts[0]);
                final lat = double.tryParse(parts[1]);
                if (lng != null && lat != null) {
                  vertices.add(LatLng(lat, lng));
                }
              }
            }

            // Remove last point if it duplicates the first
            if (vertices.length > 2 && vertices.first == vertices.last) {
              vertices.removeLast();
            }

            final name =
                placemark.findElements('name').firstOrNull?.innerText ??
                filename;
            return ImportedSurveyData(name: name, vertices: vertices);
          }
        }
      }
      return null;
    } catch (e) {
      debugPrint('KML parse error: $e');
      return null;
    }
  }
}
