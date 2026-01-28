# Project Resume: Geo Survey

## Project Title
**Geo Survey - Professional Offline GIS & Land Surveying Application**

## Project Overview
Geo Survey is a comprehensive mobile application developed using **Flutter**, designed to modernize land surveying processes. It functions as a pocket GIS tool, allowing professionals to map areas, calculate measurements, and document field data efficiently, even in **offline environments**. The app replaces traditional paper-based methods with a digital, precise, and feature-rich solution.

## Key Contributions & Technical Implementations

### 1. Advanced Geospatial Features
- **Interactive Mapping**: Implemented `flutter_map` for rendering heavy-duty maps with smooth custom interactions (drawing, dragging vertices).
- **Offline Capabilities**: Integrated **FMTC (Flutter Map Tile Caching)** to allow users to download map regions (satellite/terrain) for use in remote areas without internet access.
- **GPS Tracking (Walk-to-Draw)**: Developed a real-time tracking service using `geolocator` to automatically generate polygon boundaries by tracking the user's movement, filtering noise to ensure precision.
- **GIS Data Interoperability**: Built a custom parsing engine using `xml` and `json` to **Import KML (Google Earth)** and **GeoJSON** files, and export data back to standard GIS formats.

### 2. Robust Architecture & State Management
- **Clean Architecture**: Structured the app into clearly defined Data, Domain, and Presentation layers to ensure scalability and testability.
- **State Management**: Utilized **Riverpod** for efficient, reactive state management, handling complex states like drawing modes (measure vs polygon), GPS streams, and asynchronous database operations.
- **Local Persistence**: Implemented **Drift (SQLite)** for a type-safe, relational local database to store surveys, points, photos, and project structures offline.

### 3. Professional Data Reporting
- **PDF Report Generation**: Created a sophisticated reporting engine using the `pdf` library that combines map screenshots, statistical data (area/perimeter), and formatted tables into shareable documents.
- **Multimedia Documentation**: Integrated `image_picker` and local file management to allow attaching and managing site photos for each survey.

### 4. User Experience & Localization
- **Multi-Language Support**: Implemented full Internationalization (i18n) for **English** and **Indonesian**, with persistent language settings.
- **Intuitive UI**: Designed a tool-centric interface with floating, adaptive controls for map layers, measuring tools, and drawing actions.

## Technology Stack
- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Database**: Drift (SQLite)
- **Maps**: Flutter Map, Leaflet, OpenStreetMap
- **Native Features**: GPS (Geolocator), Camera, File System
- **Formats**: GeoJSON, KML, PDF

---
*This project demonstrates proficiency in building complex, offline-first mobile applications with heavy usage of hardware sensors, local databases, and geospatial mathematics.*
