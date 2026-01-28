import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

part 'app_database.g.dart';

/// Projects table - for organizing surveys
class Projects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Surveys table - stores polygon data and calculations
class Surveys extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  /// JSON string of List&lt;LatLng&gt; coordinates
  /// Format: [{"lat": -6.xxx, "lng": 106.xxx}, ...]
  TextColumn get geometry => text()();

  /// Calculated area in square meters
  RealColumn get areaSize => real()();

  /// Calculated perimeter in meters
  RealColumn get perimeter => real()();

  DateTimeColumn get createdAt => dateTime()();

  /// Foreign key to Projects table (nullable for surveys without project)
  TextColumn get projectId => text().nullable()();

  /// Address/location name (reverse geocoded or manual)
  TextColumn get address => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Photos attached to a survey
class SurveyPhotos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get surveyId =>
      text().references(Surveys, #id, onDelete: KeyAction.cascade)();
  TextColumn get path => text()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Drift database for GeoSurvey Pro
@DriftDatabase(tables: [Projects, Surveys, SurveyPhotos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // Add address column to surveys table
        await migrator.addColumn(surveys, surveys.address);
      }
      if (from < 3) {
        // Add survey_photos table
        await migrator.createTable(surveyPhotos);
      }
    },
  );

  // Projects CRUD
  Future<List<Project>> getAllProjects() => select(projects).get();

  Future<Project?> getProjectById(String id) =>
      (select(projects)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<int> insertProject(ProjectsCompanion project) =>
      into(projects).insert(project);

  Future<bool> updateProject(ProjectsCompanion project) =>
      update(projects).replace(project);

  Future<int> deleteProject(String id) =>
      (delete(projects)..where((p) => p.id.equals(id))).go();

  // Surveys CRUD
  Future<List<Survey>> getAllSurveys() => select(surveys).get();

  Future<List<Survey>> getSurveysByProjectId(String projectId) =>
      (select(surveys)..where((s) => s.projectId.equals(projectId))).get();

  Future<Survey?> getSurveyById(String id) =>
      (select(surveys)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<int> insertSurvey(SurveysCompanion survey) =>
      into(surveys).insert(survey);

  Future<bool> updateSurvey(SurveysCompanion survey) =>
      update(surveys).replace(survey);

  Future<int> deleteSurvey(String id) =>
      (delete(surveys)..where((s) => s.id.equals(id))).go();

  /// Get count of surveys in a project
  Future<int> getSurveyCountByProjectId(String projectId) async {
    final count = countAll();
    final query = selectOnly(surveys)
      ..addColumns([count])
      ..where(surveys.projectId.equals(projectId));

    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  // Survey Photos CRUD
  Future<List<SurveyPhoto>> getPhotosBySurveyId(String surveyId) =>
      (select(surveyPhotos)..where((p) => p.surveyId.equals(surveyId))).get();

  Future<int> insertSurveyPhoto(SurveyPhotosCompanion photo) =>
      into(surveyPhotos).insert(photo);

  Future<int> deleteSurveyPhoto(int id) =>
      (delete(surveyPhotos)..where((p) => p.id.equals(id))).go();
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Put database file in documents directory
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'geosurvey.db'));

    // Make sqlite3 available on Android
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Setup temp directory for sqlite3
    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
