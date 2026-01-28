# 🗺️ Geo Survey

**Professional Land Surveying Application** - A powerful Flutter-based mobile application for land surveying, geospatial measurements, and survey data management. Designed for professional surveyors with **Offline Capability**, **Advanced GIS Tools**, and **Multi-Language Support**.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-iOS%20|%20Android-black.svg?style=for-the-badge)

## ✨ New & Key Features

### 🛠️ Advanced GIS Tools (New!)
- **Multi-Layer Maps** - Switch between **Default**, **Satellite** (Esri World Imagery), and **Terrain** (OpenTopoMap) views.
- **Ruler / Measure Tool** - Measure distances between multiple points without creating a closed polygon.
- **Walk-to-Draw (GPS Tracking)** - Automatically record survey boundaries by walking the perimeter in real-time.
- **Photo Documentation** - Attach site photos directly to your survey (Camera or Gallery) for better visual context.
- **Data Import** - Import existing data from **KML** (Google Earth) or **GeoJSON/JSON** files directly into the app.

### 🗺️ Core Mapping System
- **Offline Maps (FMTC)** - Download regions for offline use with custom radius and preview.
- **Reverse Geocoding** - Automatically fetch address names from coordinates.
- **Interactive Editing** - Drag & drop vertices, undo/redo system, and precise polygon drawing.

### 📤 Professional Data Management
- **Universal Export** - Generate **PDF Reports** (with maps & stats), **GeoJSON** (for GIS apps), and **PNG Images**.
- **Survey History** - Manage saved surveys, view details, and initiate new actions from a dedicated history page.
- **Localization** - Full support for **English** and **Bahasa Indonesia**.
- **Local Database** - SQLite-powered storage for reliable offline data persistence.

---

## 📱 User Guide

### 1️⃣ Creating a Survey
- **Manual Draw**: Tap points on the map.
- **Walk-to-Draw**: Use the "Rekam GPS" button and walk boundaries.
- **Import**: Use the "Import KML/GeoJSON" button on the dashboard.

### 2️⃣ Advanced Tools
- **Change Layer**: Tap the Layers icon (top right) to switch to Satellite view.
- **Measure Distance**: Use the Ruler icon to measure lengths (e.g., fencing length).
- **Add Photos**: In Survey Details, tap "Tambah Foto" to document the site.

### 3️⃣ Offline Maps
1. Tap Download icon in Map View.
2. Select region and download radius.
3. Use downloaded maps anywhere without internet.

---

## 🏗️ Technical Architecture

This project follows **Clean Architecture** principles with **Riverpod** for state management.

```
lib/
├── core/                   # Utilities, Theme, Localization, Database
├── features/
│   ├── map/                # Map Logic, Drawing State, Geocoding
│   │   ├── data/           # Repositories (Drift, APIs)
│   │   ├── domain/         # Models (Entities)
│   │   └── presentation/   # MapPage, SurveyDetailPage, Widgets
│   ├── projects/           # Import Service, Project List
│   └── settings/           # Language Settings
└── main.dart
```

### Key Libraries
| Category | Library | Purpose |
|----------|---------|---------|
| **Core** | `flutter_riverpod` | State Management |
| | `drift` | Local SQLite Database |
| | `flutter_localizations` | Internationalization (i18n) |
| **Maps** | `flutter_map` | Map Rendering |
| | `geolocator` | GPS Tracking |
| | `xml` | KML Parsing |
| **Features**| `pdf` | Report Generation |
| | `image_picker` | Photo Documentation |
| | `file_picker` | Data Import |

---

## 🎯 Roadmap Status
- [x] **Phase 1: Foundation** (Architecture, Database, UI)
- [x] **Phase 2: Core Mapping** (Offline Maps, Drawing, Export)
- [x] **Phase 3: Advanced Features** (Layers, Ruler, GPS Track, Photos)
- [x] **Phase 4: Integration** (KML/GeoJSON Import, Localization, History Page)
- [ ] **Phase 5: Cloud Sync** (Future Work)

---

## 📄 License
This project is licensed under the MIT License.

**Made with ❤️ using Flutter**
