import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geosurvey/core/utils/geo_calculator.dart';

/// Drawing mode states
enum DrawingMode {
  idle, // Not drawing
  addPoint, // Tap to add vertices
  dragVertex, // Drag existing vertices
  complete, // Polygon completed
}

/// Drawing state model
class DrawingState {
  final DrawingMode mode;
  final List<LatLng> vertices;
  final int? selectedVertexIndex;
  final double area; // in square meters
  final double perimeter; // in meters

  const DrawingState({
    this.mode = DrawingMode.idle,
    this.vertices = const [],
    this.selectedVertexIndex,
    this.area = 0.0,
    this.perimeter = 0.0,
  });

  DrawingState copyWith({
    DrawingMode? mode,
    List<LatLng>? vertices,
    int? selectedVertexIndex,
    double? area,
    double? perimeter,
  }) {
    return DrawingState(
      mode: mode ?? this.mode,
      vertices: vertices ?? this.vertices,
      selectedVertexIndex: selectedVertexIndex,
      area: area ?? this.area,
      perimeter: perimeter ?? this.perimeter,
    );
  }

  bool get isDrawing =>
      mode != DrawingMode.idle && mode != DrawingMode.complete;
  bool get hasVertices => vertices.isNotEmpty;
  bool get canComplete => vertices.length >= 3;
}

/// Drawing state provider
class DrawingStateNotifier extends StateNotifier<DrawingState> {
  DrawingStateNotifier() : super(const DrawingState());

  /// Start drawing mode
  void startDrawing() {
    state = const DrawingState(mode: DrawingMode.addPoint);
  }

  /// Add a vertex at the tapped location
  void addVertex(LatLng point) {
    if (state.mode != DrawingMode.addPoint) return;

    final newVertices = [...state.vertices, point];
    _updateStateWithCalculations(newVertices);
  }

  /// Update vertex position (for dragging)
  void updateVertex(int index, LatLng newPosition) {
    if (index < 0 || index >= state.vertices.length) return;

    final newVertices = [...state.vertices];
    newVertices[index] = newPosition;
    _updateStateWithCalculations(newVertices);
  }

  /// Remove last vertex (undo)
  void removeLastVertex() {
    if (state.vertices.isEmpty) return;

    final newVertices = state.vertices.sublist(0, state.vertices.length - 1);
    _updateStateWithCalculations(newVertices);
  }

  /// Clear all vertices
  void clearPolygon() {
    state = const DrawingState(mode: DrawingMode.addPoint);
  }

  /// Complete polygon drawing
  void completePolygon() {
    if (!state.canComplete) return;

    state = state.copyWith(mode: DrawingMode.complete);
  }

  /// Cancel drawing and reset
  void cancelDrawing() {
    state = const DrawingState();
  }

  /// Switch to drag mode
  void enableDragMode() {
    if (!state.hasVertices) return;
    state = state.copyWith(mode: DrawingMode.dragVertex);
  }

  /// Switch back to add point mode
  void enableAddPointMode() {
    state = state.copyWith(
      mode: DrawingMode.addPoint,
      selectedVertexIndex: null,
    );
  }

  /// Select a vertex for dragging
  void selectVertex(int index) {
    if (state.mode != DrawingMode.dragVertex) return;
    state = state.copyWith(selectedVertexIndex: index);
  }

  /// Deselect vertex
  void deselectVertex() {
    state = state.copyWith(selectedVertexIndex: null);
  }

  /// Update state with recalculated area and perimeter
  void _updateStateWithCalculations(List<LatLng> vertices) {
    double area = 0.0;
    double perimeter = 0.0;

    if (vertices.length >= 3) {
      area = GeoCalculator.calculateArea(vertices);
      perimeter = GeoCalculator.calculatePerimeter(vertices);
    }

    state = state.copyWith(
      vertices: vertices,
      area: area,
      perimeter: perimeter,
    );
  }
}

/// Provider for drawing state
final drawingStateProvider =
    StateNotifierProvider<DrawingStateNotifier, DrawingState>((ref) {
      return DrawingStateNotifier();
    });
