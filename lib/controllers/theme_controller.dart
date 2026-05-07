import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();
  static const _themeModeKey = 'themeMode';

  final themeMode = ThemeMode.system.obs;

  Future<void> loadThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedThemeMode = preferences.getString(_themeModeKey);
    themeMode.value = _themeModeFromName(savedThemeMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_themeModeKey, mode.name);
  }

  String labelFor(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  ThemeMode _themeModeFromName(String? name) {
    for (final mode in ThemeMode.values) {
      if (mode.name == name) {
        return mode;
      }
    }
    return ThemeMode.system;
  }
}
