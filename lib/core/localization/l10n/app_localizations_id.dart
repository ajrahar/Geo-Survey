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
}
