import 'package:flutter/material.dart';
import 'package:pharmate/ui/accessibility_theme_preference.dart';

class AccessibilityProvider with ChangeNotifier {
  bool _accessibleTheme = false;
  AccessibleThemePreference accessibleThemePreference = AccessibleThemePreference();
  bool get isAccessibleFont => _accessibleTheme;

  AccessibilityProvider() {
    getPreferences();
  }

  getPreferences() async{
    bool? getAccessibleTheme = await accessibleThemePreference.getTheme();
    if (getAccessibleTheme != null) {
      _accessibleTheme = getAccessibleTheme;
      notifyListeners();
    }
  }

  set isAccessibleFont(bool value) {
    _accessibleTheme = value;
    accessibleThemePreference.setAccessibleTheme(value);
    notifyListeners();
  }
}