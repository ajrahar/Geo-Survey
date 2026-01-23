import 'package:drift/drift.dart';
import 'package:geosurvey/core/database/app_database.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';

/// Repository for Survey CRUD operations
class SurveyRepository {
  final AppDatabase _database;

  SurveyRepository(this._database);

  /// Get all surveys
  Future<List<Survey>> getAllSurveys() async {
    return await _database.getAllSurveys();
  }

  /// Get survey by ID
  Future<Survey?> getSurveyById(String id) async {
    return await _database.getSurveyById(id);
  }

  /// Save new survey
  Future<String> saveSurvey({
    required String id,
    required String name,
    required List<LatLng> vertices,
    required double areaSize,
    required double perimeter,
    String address = '',
  }) async {
    // Serialize vertices to JSON
    final geometryJson = jsonEncode(
      vertices.map((v) => {'lat': v.latitude, 'lng': v.longitude}).toList(),
    );

    final survey = SurveysCompanion(
      id: Value(id),
      name: Value(name),
      geometry: Value(geometryJson),
      areaSize: Value(areaSize),
      perimeter: Value(perimeter),
      createdAt: Value(DateTime.now()),
      projectId: const Value(null),
      address: Value(address),
    );

    await _database.insertSurvey(survey);
    return id;
  }

  /// Update existing survey
  Future<void> updateSurvey({
    required String id,
    required String name,
    required List<LatLng> vertices,
    required double areaSize,
    required double perimeter,
    String address = '',
  }) async {
    final geometryJson = jsonEncode(
      vertices.map((v) => {'lat': v.latitude, 'lng': v.longitude}).toList(),
    );

    final survey = SurveysCompanion(
      id: Value(id),
      name: Value(name),
      geometry: Value(geometryJson),
      areaSize: Value(areaSize),
      perimeter: Value(perimeter),
      createdAt: Value(DateTime.now()),
      projectId: const Value(null),
      address: Value(address),
    );

    await _database.updateSurvey(survey);
  }

  /// Delete survey
  Future<void> deleteSurvey(String id) async {
    await _database.deleteSurvey(id);
  }

  /// Parse vertices from geometry JSON string
  List<LatLng> parseVertices(String geometryJson) {
    try {
      final List<dynamic> points = jsonDecode(geometryJson);
      return points
          .map((p) => LatLng(p['lat'] as double, p['lng'] as double))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
