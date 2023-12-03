import 'package:flutter/material.dart';
import 'package:pharmate/data/accessibility_theme_preference.dart';

class AccessibilityProvider with ChangeNotifier {
  bool _accessibleTheme = false;
  AccessibleThemePreference accessibleThemePreference = AccessibleThemePreference();
  bool get isAccessibleFont => _accessibleTheme;

  AccessibilityProvider() {
    getPreferences();
  }

  getPreferences() async{
    _accessibleTheme = (await accessibleThemePreference.getTheme())!;
    notifyListeners();
  }

  set isAccessibleFont(bool value) {
    _accessibleTheme = value;
    accessibleThemePreference.setAccessibleTheme(value);
    notifyListeners();
  }
}