import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme_mode';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _load();
  }

  final SharedPreferences _prefs;

  void _load() {
    final value = _prefs.getString(_themeKey);
    switch (value) {
      case 'light':
        emit(ThemeMode.light);
      case 'dark':
        emit(ThemeMode.dark);
      default:
        emit(ThemeMode.system);
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    emit(mode);
    await _prefs.setString(_themeKey, mode.name);
  }
}

ThemeData get lightTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    );

ThemeData get darkTheme => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
