# 🗺️ Geo Survey

**Professional Land Surveying Application** - A powerful Flutter-based mobile application for land surveying, geospatial measurements, and survey data management. Now with **Offline Maps** and **Professional PDF Reports**.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/license-MIT-green.svg?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-iOS%20|%20Android-black.svg?style=for-the-badge)

## ✨ Key Features

### 🗺️ Advanced Mapping System
- **Offline Maps (FMTC)** - Download map regions for offline use. Features include:
  - Custom region selection with preview
  - Configurable download radius (1km - 20km)
  - Estimated tile count and size calculation
  - Seamless online/offline switching
- **Reverse Geocoding** - Automatically fetch human-readable addresses from coordinates using **Nominatim API**.
- **Interactive Controls** - Smooth zoom controls, pan, rotation, and current location tracking.

### 📍 Precision Surveying Tools
- **Polygon Drawing** - Intuitive tap-to-place interface for defining boundaries.
- **Vertex Management** - Drag & drop vertex editing with high precision.
- **Real-time Calculations** - Instant updates for:
  - **Area**: m², hectares (ha), km²
  - **Perimeter**: meters (m), kilometers (km)
- **Undo/Redo System** - Fail-safe editing with history stack.

### 📤 Professional Export Suite
- **PDF Reports** - Generate comprehensive survey reports containing:
  - High-resolution map screenshot
  - Project details & timestamps
  - Measurement statistics
  - Formatted coordinate tables (Lat/Long)
- **GeoJSON Export** - Standard GIS format compatible with QGIS, ArcGIS, and Google Earth.
- **Image Export** - Quick sharing of map visuals as PNG files.

### 💾 Data & Architecture
- **Local Database** - Robust SQLite storage using `drift` for offline persistence.
- **Clean Architecture** - Scalable codebase separating Data, Domain, and Presentation layers.
- **State Management** - Modern **Riverpod** implementation for reactive UI updates.

---

## 📱 User Guide

### 1️⃣ Creating a Survey
1. Tap **"Mulai Survey Baru"** on the dashboard.
2. Select a project or create a new one.
3. Enter survey details (Name, Address).
4. **Draw**: Tap on the map to place points. Minimum 3 points required for a polygon.
5. **Edit**: Select a point to drag it, or use Undo/Redo/Clear buttons.
6. **Save**: Tap the save icon to persist data.

### 2️⃣ Offline Maps (Download)
1. In Map View, tap the **Download** icon (top right).
2. Pan the map to your desired area.
3. Adjust the **Radius Slider** (e.g., 5 km) and zoom depth.
4. Tap **"Cek Estimasi"** to see download size.
5. Tap **"Mulai Download"** to cache tiles locally.

### 3️⃣ Export & Share
1. Open a saved Survey from the list.
2. Tap the **Share/Export** icon in the App Bar.
3. Choose format:
   - **GeoJSON**: For GIS analysis.
   - **PNG**: For quick sharing.
   - **PDF Report**: For formal documentation.
4. Select target app (WhatsApp, Email, Drive, etc.).

### 4️⃣ Getting Address (Geocoding)
1. In Survey Details, scroll to the Address section.
2. If address is missing, tap **"Tap untuk ambil alamat dari koordinat"**.
3. The app will fetch the location name from OpenStreetMap via API.

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
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

3. **Generate code (Riverpod/Freezed/Drift)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🏗️ Technical Architecture

This project follows **Clean Architecture** principles:

```
lib/
├── core/                   # Creating survey entities
│   ├── constants/          # App-wide constants
│   ├── database/           # Drift (SQLite) setup
│   ├── theme/              # Material 3 Theme & Colors
│   └── utils/              # Calculators, Exporters, Formatters
├── features/
│   ├── map/                # Map & Survey Module
│   │   ├── data/           # Repositories & Data Sources
│   │   ├── domain/         # Entities & Use Cases
│   │   └── presentation/   # UI: Pages, Widgets, Providers
│   └── projects/           # Project Management Module
└── main.dart               # Entry point
```

### Key Libraries
| Category | Library | Purpose |
|----------|---------|---------|
| **Core** | `flutter_riverpod` | State Management |
| | `freezed` | Immutable Data Classes |
| | `drift` | SQLite Database |
| **Maps** | `flutter_map` | Map Rendering |
| | `flutter_map_tile_caching` | Offline Maps (v10) |
| | `latlong2` | Coordinate Math |
| **Features**| `pdf` | Report Generation |
| | `screenshot` | Widget Capture |
| | `http` | API Calls (Geocoding) |

---

## 🎯 Roadmap Status

- [x] **Phase 1: Foundation** (Project Setup, Theme, Routing)
- [x] **Phase 2: Database** (Drift Setup, CRUD)
- [x] **Phase 3: Offline Maps** (Tile Caching System)
- [x] **Phase 4: Map UI** (Drawing, Zoom Controls, Layers)
- [x] **Phase 5: Survey Logic** (Area/Perimeter Calc, Editing)
- [x] **Phase 6: Projects** (Management & Organization)
- [x] **Phase 7: Export** (GeoJSON, PNG, PDF)
- [x] **Phase 8: Geocoding** (Reverse Geocoding API)
- [ ] **Phase 9: Advanced Tools** (Import, Cloud Sync - Coming Soon)

---

## 🤝 Contributing

Contributions are welcome!
1. Fork the repo
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ using Flutter**
