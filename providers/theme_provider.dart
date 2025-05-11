
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> init() async {
    await _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkMode ? darkTheme : lightTheme;
  }
  final ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue.shade800,
    onPrimary: Colors.white,
    secondary: Colors.blue.shade600,
    onSecondary: Colors.white,
    error: Colors.red.shade600,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );

  final ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.blue.shade200,
    onPrimary: Colors.black,
    secondary: Colors.blue.shade600,
    onSecondary: Colors.black,
    error: Colors.red.shade300,
    onError: Colors.black,
    surface: Colors.black,
    onSurface: Colors.white,
  );

  // Dark and light theme colors
  ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue.shade800,
      hintColor: Colors.blue.shade600,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.blue.shade800), colorScheme: lightColorScheme,
    );
  }

  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue.shade800,
      hintColor: Colors.blue.shade600,
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.blue.shade800), colorScheme:darkColorScheme,
    );
  }
}
