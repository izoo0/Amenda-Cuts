import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String themePath = 'themePath';

class ThemeProvider extends ChangeNotifier {
  int _currentTheme = 0;

  int get currentTheme => _currentTheme;

  ThemeMode get themeMode {
    switch (_currentTheme) {
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future init() async {
    await getTheme();
    notifyListeners();
  }

  Future getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _currentTheme = preferences.getInt(themePath) ?? 0;
    notifyListeners();
  }

  Future setTheme(int setTheme) async {
    _currentTheme = setTheme;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(themePath, setTheme);
    notifyListeners();
  }
}
