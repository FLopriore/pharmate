import 'package:flutter/material.dart';
import 'package:pharmate/data/dark_theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool get darkTheme => _darkTheme;

  DarkMode(){
    _darkTheme = false;
    darkThemePreference = DarkThemePreference();
    getPreferences();
  }

  getPreferences() async{
    _darkTheme = await darkThemePreference.getTheme();
    notifyListeners();
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}