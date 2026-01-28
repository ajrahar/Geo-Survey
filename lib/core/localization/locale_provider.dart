import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

const String _localeKey = 'selected_locale';

@riverpod
class LocaleController extends _$LocaleController {
  @override
  AppLocale build() {
    _loadLocale();
    return const AppLocale(Locale('id')); // Default to Indonesian
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey);
      if (localeCode != null) {
        state = AppLocale(Locale(localeCode));
      }
    } catch (e) {
      debugPrint('Error loading locale: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    state = AppLocale(locale);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }
}

class AppLocale {
  final Locale locale;
  const AppLocale(this.locale);
}
