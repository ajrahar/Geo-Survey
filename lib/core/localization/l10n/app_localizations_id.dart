// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Geo Survey';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get languageTitle => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get projectListTitle => 'Geo Survey';

  @override
  String get startNewSurvey => 'Mulai Survey Baru';

  @override
  String get viewSurveyHistory => 'Riwayat Survey';

  @override
  String get welcomeMessage => 'Selamat Datang di Geo Survey';

  @override
  String get welcomeSubtitle =>
      'Aplikasi pemetaan lahan offline untuk surveyor profesional';

  @override
  String get mapTitle => 'Peta Survey';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get surveyName => 'Nama Survey';

  @override
  String get surveyNameHint => 'Contoh: Lahan Sawah A';

  @override
  String get surveyNameError => 'Nama survey tidak boleh kosong';

  @override
  String saveSuccess(String name) {
    return 'Survey \"$name\" berhasil disimpan!';
  }

  @override
  String get statistics => 'Statistik';

  @override
  String get pointCount => 'Jumlah Titik';

  @override
  String get areaSize => 'Luas Area';

  @override
  String get perimeter => 'Keliling';

  @override
  String get importSurvey => 'Import KML/GeoJSON';

  @override
  String get importSuccess => 'Import berhasil';

  @override
  String importError(String error) {
    return 'Import gagal: $error';
  }

  @override
  String get mapModeView => 'Mode: Lihat Peta';

  @override
  String get mapModeInstruction => 'Tap \"Mulai Gambar\" untuk membuat polygon';

  @override
  String get measureDistance => 'Ukur Jarak';

  @override
  String get polygonStatistics => 'Statistik Polygon';

  @override
  String get totalDistance => 'Jarak Total';

  @override
  String get measureInstruction => 'Tap 2 titik untuk mengukur jarak';

  @override
  String get polygonInstruction => 'Minimal 3 titik untuk membuat polygon';

  @override
  String get downloadOfflineMap => 'Download Peta Offline';

  @override
  String get startDrawing => 'Mulai Gambar';

  @override
  String get gpsRecord => 'Rekam GPS';

  @override
  String get gpsWalkInstruction => 'Berjalanlah untuk merekam area';

  @override
  String get saveSurvey => 'Simpan';

  @override
  String get saveSurveyTitle => 'Simpan Survey';

  @override
  String get pointMoved => 'Titik berhasil dipindahkan';

  @override
  String get minPointsError => 'Minimal 3 titik untuk menyimpan polygon';

  @override
  String get surveyDetail => 'Detail Survey';

  @override
  String get dateCreated => 'Tanggal Dibuat';

  @override
  String get address => 'Alamat';

  @override
  String get fetchAddress => 'Tap untuk ambil alamat dari koordinat';

  @override
  String get fetchingAddress => 'Mengambil alamat...';

  @override
  String get photoDocumentation => 'Dokumentasi Foto';

  @override
  String get addPhoto => 'Tambah Foto';

  @override
  String get noPhotos => 'Belum ada foto dokumentasi';

  @override
  String get coordinates => 'Koordinat Titik';

  @override
  String get exportGeoJson => 'Export GeoJSON';

  @override
  String get exportPng => 'Export PNG Image';

  @override
  String get exportPdf => 'Export PDF Report';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galeri';

  @override
  String get photoAdded => 'Foto berhasil ditambahkan';

  @override
  String get photoDeleted => 'Foto dihapus';

  @override
  String deletePhotoError(String error) {
    return 'Gagal menghapus foto: $error';
  }

  @override
  String addPhotoError(String error) {
    return 'Gagal menambahkan foto: $error';
  }

  @override
  String get surveyHistoryTitle => 'Riwayat Survey';

  @override
  String get noSurveys => 'Belum ada survey';

  @override
  String get createSurveyInstruction =>
      'Tap tombol + untuk membuat survey baru';

  @override
  String get deleteSurveyTitle => 'Hapus Survey?';

  @override
  String deleteSurveyContent(String name) {
    return 'Survey \"$name\" akan dihapus permanen.';
  }

  @override
  String get delete => 'Hapus';

  @override
  String get deleteSuccess => 'Survey berhasil dihapus';

  @override
  String get cameraOption => 'Ambil Foto (Kamera)';

  @override
  String get galleryOption => 'Pilih dari Galeri';

  @override
  String get exportGeoJsonSubtitle => 'Format standar untuk GIS';

  @override
  String get exportPngSubtitle => 'Screenshot peta sebagai gambar';

  @override
  String get exportPdfSubtitle => 'Laporan lengkap dengan statistik';

  @override
  String get capturingScreenshot => 'Mengambil screenshot...';

  @override
  String get generatingPdf => 'Membuat PDF report...';

  @override
  String exportSuccess(String type) {
    return '$type berhasil di-export!';
  }

  @override
  String exportError(String type, String error) {
    return 'Gagal export $type: $error';
  }

  @override
  String get addressFromCoords => 'Alamat (dari koordinat)';

  @override
  String pointCountValue(int count) {
    return '$count titik';
  }
}
