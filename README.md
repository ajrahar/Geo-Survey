# 🗺️ Geo Survey

**Professional Land Surveying Application** - A powerful Flutter-based mobile application for land surveying, geospatial measurements, and survey data management.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## ✨ Features

### 🎯 Core Surveying
- **Interactive Polygon Drawing** - Draw survey boundaries with tap-to-place markers
- **Drag & Drop Editing** - Move vertices with precision for accurate boundaries
- **Real-time Calculations** - Instant area and perimeter measurements
- **Multi-unit Support** - Display in m², hectares, meters, and kilometers
- **Undo/Redo** - Full editing history with undo/redo functionality

### 📊 Data Management
- **SQLite Database** - Persistent local storage with schema migrations
- **Survey History** - View, search, and manage all past surveys
- **CRUD Operations** - Create, read, update, and delete surveys
- **Address Field** - Store location details with each survey
- **Automatic Backups** - Database migration support for updates

### 📤 Export Capabilities
- **GeoJSON Export** - Standard GIS format compatible with QGIS, ArcGIS, Google Earth
- **PNG Image Export** - High-quality map screenshots with polygon overlays
- **PDF Report Export** - Professional reports with:
  - Survey header (name, date, ID, address)
  - Embedded map screenshot
  - Statistics table (area, perimeter, coordinates)
  - Detailed coordinate table for all vertices
  - Auto-generated timestamp footer

### 🗺️ Mapping Features
- **OpenStreetMap Integration** - Free, open-source map tiles
- **Offline Tile Caching** - Download maps for offline use with FMTC
- **Custom Download Regions** - Select area, radius, and zoom levels
- **Interactive Map Controls** - Pan, zoom, and rotate
- **Real-time Tile Loading** - Seamless online/offline switching

### 🎨 User Experience
- **Custom Top Notifications** - Elegant slide-down notifications with auto-dismiss
- **Material Design 3** - Modern, clean UI with dark mode support
- **Responsive Layout** - Optimized for all screen sizes
- **Smooth Animations** - Polished transitions and interactions
- **Professional Theming** - Consistent color scheme and typography

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart SDK 3.0 or higher
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/geosurvey.git
cd geosurvey
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code**
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app**
```bash
flutter run
```

## 📱 Usage

### Creating a Survey

1. **Start New Survey**
   - Tap "Mulai Survey Baru" on home screen
   - Enter survey name and optional address

2. **Draw Polygon**
   - Tap map to place vertices
   - Minimum 3 points required
   - Watch real-time area/perimeter updates

3. **Edit Vertices**
   - Tap "Edit" mode to enable drag & drop
   - Move markers to adjust boundaries
   - Use undo/redo for corrections

4. **Save Survey**
   - Tap save button when complete
   - Survey stored in local database
   - Accessible from history

### Exporting Data

1. **Open Survey Details**
   - Tap any survey from history
   - View map and statistics

2. **Choose Export Format**
   - Tap share icon (⬆️) in app bar
   - Select export type:
     - **GeoJSON** - For GIS software
     - **PNG Image** - For presentations
     - **PDF Report** - For documentation

3. **Share**
   - Native share dialog opens
   - Share via WhatsApp, Email, Drive, etc.

### Offline Maps

1. **Download Tiles**
   - Tap download icon in map view
   - Select center point on map
   - Adjust radius (1-20 km)
   - Set zoom levels (min/max)
   - View estimated tiles & size
   - Tap "Mulai Download"

2. **Use Offline**
   - Downloaded tiles cached permanently
   - Automatic fallback when offline
   - Seamless online/offline switching

## 🏗️ Architecture

### Clean Architecture Pattern
```
lib/
├── core/
│   ├── constants/      # App-wide constants
│   ├── database/       # Drift database setup
│   ├── theme/          # App theming
│   ├── utils/          # Utility functions
│   └── widgets/        # Reusable widgets
├── features/
│   ├── map/
│   │   ├── data/       # Data sources
│   │   ├── domain/     # Business logic
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   └── projects/
│       └── presentation/
└── main.dart
```

### State Management
- **Riverpod** - Modern, compile-safe state management
- **Code Generation** - Type-safe providers with riverpod_generator
- **Immutable State** - Freezed for data classes

### Database Schema

**Projects Table**
```sql
CREATE TABLE projects (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  created_at INTEGER NOT NULL
);
```

**Surveys Table**
```sql
CREATE TABLE surveys (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  geometry TEXT NOT NULL,
  area_size REAL NOT NULL,
  perimeter REAL NOT NULL,
  created_at INTEGER NOT NULL,
  project_id TEXT NOT NULL,
  address TEXT NOT NULL DEFAULT '',
  FOREIGN KEY (project_id) REFERENCES projects(id)
);
```

## 🧪 Testing

### Run Tests
```bash
# All tests
flutter test

# Unit tests only
flutter test test/unit/

# With coverage
flutter test --coverage
```

### Test Coverage
- **15 Unit Tests** - Core functionality
- **Geo Calculator** - Area, perimeter, distance calculations
- **GeoJSON Exporter** - Format validation, coordinate ordering
- **100% Critical Path Coverage**

### Code Quality
```bash
# Analyze code
flutter analyze

# Format code
dart format lib/ test/
```

## 📦 Tech Stack

### Core
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language

### Mapping
- **flutter_map** - Interactive map widget
- **flutter_map_tile_caching** - Offline tile storage
- **latlong2** - Coordinate handling
- **turf** - Geospatial calculations

### State Management
- **flutter_riverpod** - State management
- **riverpod_generator** - Code generation
- **riverpod_annotation** - Annotations

### Database
- **drift** - Type-safe SQL database
- **sqlite3** - SQLite engine
- **sqlite3_flutter_libs** - Platform bindings

### Export
- **pdf** - PDF generation
- **screenshot** - Map capture
- **share_plus** - Native sharing

### Utilities
- **uuid** - Unique ID generation
- **intl** - Internationalization
- **path_provider** - File system access

## 🎯 Roadmap

### v2.0 (Planned)
- [ ] Manual coordinate input
- [ ] Coordinate display on markers
- [ ] GPS integration for auto-tracking
- [ ] Cloud sync & backup
- [ ] Multi-user collaboration
- [ ] Advanced measurement tools
- [ ] Custom map layers
- [ ] Offline-first architecture

### v1.1 (Future)
- [ ] Import from GeoJSON
- [ ] Batch export
- [ ] Survey templates
- [ ] Custom units
- [ ] Measurement history
- [ ] Export to KML/KMZ

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

## 🙏 Acknowledgments

- OpenStreetMap contributors for map data
- Flutter team for amazing framework
- flutter_map community for mapping tools
- All open-source contributors

## 📞 Support

For support, email your.email@example.com or open an issue on GitHub.

---

**Made with ❤️ using Flutter**
