# 🗺️ Geo Survey

**Offline GIS Data Collector for Professional Land Surveying**

[![Flutter](https://img.shields.io/badge/Flutter-3.27+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Geo Survey adalah aplikasi mobile untuk pemetaan lahan dan pengumpulan data geospasial di area remote (tanpa sinyal). Dirancang khusus untuk surveyor profesional yang membutuhkan akurasi tinggi dan kemampuan offline-first.

---

## ✨ Fitur Utama

### 🎨 Interactive Polygon Drawing
- **Tap-to-Add Vertices**: Gambar polygon dengan mudah hanya dengan tap peta
- **Numbered Markers**: Setiap vertex diberi nomor urut untuk tracking yang jelas
- **Drag & Reposition**: Mode drag untuk memindahkan vertex dengan tap marker → tap peta
- **Undo/Clear**: Hapus vertex terakhir atau clear semua dengan confirmation
- **Real-Time Preview**: Polygon ter-render langsung saat menggambar

### 📐 Geospatial Calculations
- **Area Calculation**: Perhitungan luas area otomatis dalam m² atau hectares
- **Perimeter Calculation**: Keliling polygon dalam meters atau kilometers
- **Geodesic Accuracy**: Menggunakan Turf.js untuk perhitungan akurat dengan Earth's curvature
- **Auto-Format Units**: Konversi otomatis ke unit yang sesuai (m² → ha, m → km)

### 💾 Local Database & History
- **SQLite Database**: Penyimpanan lokal dengan Drift ORM
- **Auto-Refresh**: UI update otomatis saat data berubah (Stream providers)
- **Survey History**: List semua survey dengan cards yang informatif
- **Detail View**: Map view + statistics panel untuk setiap survey
- **Delete with Confirmation**: Hapus survey dengan dialog konfirmasi

### 🎯 Professional UI/UX
- **Custom Top Notifications**: Notifikasi slide dari atas dengan animasi smooth (3 detik auto-dismiss)
- **Material 3 Design**: Modern UI dengan Poppins font family
- **Teal/Green Theme**: Warna yang cocok untuk aplikasi GIS
- **Dark Mode Support**: Light & dark theme (auto-switch)
- **Responsive Layout**: Optimized untuk berbagai ukuran layar

### 🗺️ OpenStreetMap Integration
- **OSM Tiles**: Menggunakan OpenStreetMap public tiles
- **Zoom Controls**: Zoom in/out dengan floating buttons
- **Pan & Rotate**: Interaksi peta yang smooth
- **Attribution**: Proper OSM attribution

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.27 or higher
- **Dart SDK**: 3.6 or higher
- **Android Studio** / **Xcode** (for mobile development)

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

3. **Generate code** (Drift, Riverpod, etc.)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 🏗️ Architecture

Geo Survey menggunakan **Clean Architecture** dengan struktur folder yang jelas:

```
lib/
├── core/
│   ├── constants/          # App & map constants
│   ├── database/           # Drift database schema
│   ├── errors/             # Error handling
│   ├── theme/              # App theme & colors
│   ├── utils/              # Geo calculator utilities
│   └── widgets/            # Reusable widgets (TopNotification)
│
├── features/
│   ├── map/
│   │   ├── data/
│   │   │   └── repositories/    # Survey repository (CRUD)
│   │   └── presentation/
│   │       ├── pages/           # MapPage, SurveyListPage, SurveyDetailPage
│   │       ├── providers/       # Riverpod providers
│   │       └── widgets/         # Drawing toolbar, polygon layer, info panel
│   │
│   └── projects/
│       └── presentation/
│           └── pages/           # ProjectListPage (home)
│
└── main.dart                    # App entry point
```

---

## 🛠️ Tech Stack

### Core Framework
- **Flutter** - Cross-platform mobile framework
- **Dart** - Programming language

### State Management
- **Riverpod** - Reactive state management with providers

### Database
- **Drift** - Type-safe SQL database (SQLite)
- **sqlite3_flutter_libs** - SQLite native libraries

### Maps & Geospatial
- **flutter_map** - OpenStreetMap integration
- **latlong2** - LatLng coordinate handling
- **turf** - Geospatial analysis (area, perimeter, distance)

### UI/UX
- **Material 3** - Modern Material Design
- **Google Fonts (Poppins)** - Custom font family
- **font_awesome_flutter** - Icon library

### Utilities
- **intl** - Internationalization & date formatting
- **uuid** - Unique ID generation
- **share_plus** - File sharing (future: GeoJSON export)
- **permission_handler** - Permission management

### Code Generation
- **build_runner** - Code generation runner
- **drift_dev** - Drift database code generation
- **riverpod_generator** - Riverpod provider generation
- **json_serializable** - JSON serialization
- **freezed** - Immutable data classes

---

## 📊 Database Schema

### Surveys Table
```sql
CREATE TABLE surveys (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  geometry TEXT NOT NULL,      -- JSON: [{"lat": -6.2, "lng": 106.8}, ...]
  area_size REAL NOT NULL,      -- in square meters
  perimeter REAL NOT NULL,      -- in meters
  created_at INTEGER NOT NULL,  -- Unix timestamp
  project_id TEXT,              -- Foreign key (nullable)
  address TEXT DEFAULT ''       -- Location address
);
```

### Projects Table
```sql
CREATE TABLE projects (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  created_at INTEGER NOT NULL
);
```

---

## 🎯 User Flow

### Creating a Survey

1. **Launch App** → Home screen dengan 2 buttons
2. **Tap "Mulai Survey Baru"** → Navigate to MapPage
3. **Tap "Mulai Gambar"** → Enter drawing mode
4. **Tap peta 4+ kali** → Create polygon vertices
5. **See real-time stats** → Area & perimeter di info panel
6. **Optional: Drag vertices** → Tap "Geser" → select marker → tap new location
7. **Tap "Selesai"** → Complete polygon
8. **Tap "Simpan"** → Enter survey name
9. **Confirm** → Survey saved to database
10. **Success notification** → Top notification slide dari atas

### Viewing History

1. **Home → "Lihat Riwayat Survey"** → Survey list page
2. **See all surveys** → Cards dengan name, date, area, perimeter
3. **Tap card** → Survey detail page
4. **View map** → Polygon dengan numbered markers
5. **View statistics** → Date, vertices count, area, perimeter
6. **Optional: Delete** → Tap delete icon → confirm

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Manual Testing Checklist

- [ ] Create polygon dengan 4+ vertices
- [ ] Real-time area/perimeter calculation
- [ ] Drag vertex to new location
- [ ] Undo last vertex
- [ ] Clear all vertices
- [ ] Save survey dengan nama
- [ ] View survey history
- [ ] Tap survey card → detail page
- [ ] Delete survey dengan confirmation
- [ ] Top notification animations

---

## 🔮 Roadmap

### Phase 7: GeoJSON Export/Import ⏳
- [ ] Serialize survey to GeoJSON format
- [ ] File I/O untuk save GeoJSON
- [ ] Share functionality
- [ ] Import GeoJSON (optional)

### Phase 8: UI/UX Polish ⏳
- [ ] Hero transitions
- [ ] Loading states
- [ ] Illustrations
- [ ] Onboarding flow

### Phase 9: Advanced Features 📋
- [ ] Offline tile caching (FMTC)
- [ ] Reverse geocoding untuk address
- [ ] Photo attachments
- [ ] Multi-project support
- [ ] Cloud sync (optional)

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙏 Acknowledgments

- **OpenStreetMap** - Map tiles & data
- **Flutter Team** - Amazing framework
- **Turf.js** - Geospatial calculations
- **Drift Team** - Type-safe database

---

<p align="center">
  Made with ❤️ for Surveyor Professionals
</p>
