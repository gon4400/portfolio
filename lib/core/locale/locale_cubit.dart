import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _localeKey = 'app_locale';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit(this._prefs) : super(null) {
    _load();
  }

  final SharedPreferences _prefs;

  void _load() {
    final code = _prefs.getString(_localeKey);
    if (code == null) return;
    final parts = code.split('_');
    emit(parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(code));
  }

  Future<void> setLocale(Locale? locale) async {
    emit(locale);
    if (locale == null) {
      await _prefs.remove(_localeKey);
      return;
    }
    final code =
        locale.countryCode == null || (locale.countryCode?.isEmpty ?? true)
            ? locale.languageCode
            : '${locale.languageCode}_${locale.countryCode}';
    await _prefs.setString(_localeKey, code);
  }
}
