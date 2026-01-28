# 📄 Project Resume: Geo Survey

## 🚀 Project Overview
**Geo Survey** is a professional-grade mobile application designed for land surveying, geospatial measurements, and field data management. Built with **Flutter**, it operates fully offline, providing surveyors with advanced mapping tools, coordinate tracking, and reliable data persistence.

The project demonstrates advanced mobile capabilities including **GPS tracking**, **custom map rendering**, **spatial calculations**, **multimedia attachments**, and **interoperability with GIS standards (GeoJSON/KML)**.

---

## 🛠️ Technical Stack

- **Framework**: Flutter (Dart 3.0+)
- **Architecture**: Clean Architecture (Layered: Data, Domain, Presentation)
- **State Management**: Riverpod (Providers, Consumers, Notifiers)
- **Database**: Drift (SQLite abstraction with strict schema)
- **Maps**: `flutter_map` (OpenStreetMap integration, Offline Tile Caching via FMTC)
- **Geospatial**: `latlong2`, `geolocator`, `xml` (KML parsing)
- **Localization**: `flutter_localizations` (ARB-based i18n for EN/ID)
- **PDF/Image**: `pdf` package for reports, `screenshot` for map capturing

---

## 🌟 Key Features Implemented

### 1. Interactive Map & Drawing
- **Vertex Editing**: Drag-and-drop points to adjust polygons.
- **Tools**: Ruler (distance measurement), Walk-to-Draw (GPS recording), and Satellite/Terrain layers.
- **Offline Mode**: Download map tiles by radius for use without internet.

### 2. Data Management
- **Survey History**: List, view, and manage past surveys with detailed statistics (Area, Perimeter).
- **Photo Documentation**: Attach site photos to specific surveys using Camera or Gallery.
- **Import**: Support for importing **KML** (Google Earth) and **GeoJSON**.

### 3. Reporting & Export
- **PDF Reports**: Professional reports containing map screenshots, property details, coordinates list, and photos.
- **GeoJSON Export**: Standard GIS format export for interoperability with ArcGIS/QGIS.
- **Image Export**: High-resolution PNG export of the surveyed boundary.

### 4. User Experience
- **Localization**: Full support for **Bahasa Indonesia** and **English**.
- **Usability**: Real-time area calculation, intuitive FAB controls, and automated address fetching (Reverse Geocoding).

---

## 💡 Technical Challenges Solved

- **Offline Tile Management**: Implemented a caching mechanism using `flutter_map_tile_caching` to allow surveyors to work in remote areas with no signal.
- **Complex Spatial Math**: Implemented Shoelace formula for area calculation and Haversine formula for perimeter/distance, handling earth's curvature.
- **Clean State Management**: Decoupled drawing logic (drag, add, measure) into a `DrawingStateNotifier` to maintain UI responsiveness and testability.
- **File System Handling**: robust handling of external file imports/exports on Android/iOS storage systems.

---

## 📅 Development Status
Completed phases:
- [x] Core Architecture & Database
- [x] Basic Mapping & Polygon Drawing
- [x] Advanced Tools (Layers, Ruler, GPS)
- [x] Data Integration (Import/Export, Localization)

**Current Version**: 1.0.0 (Production Ready MVP)
