import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_feed_app/data/storage/local_storage_service.dart';
import 'package:news_feed_app/core/constants.dart';

class SettingsController extends GetxController {
  final LocalStorageService _storage = LocalStorageService();
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.getThemeMode();
    switch (saved) {
      case AppStrings.darkTheme:
        themeMode.value = ThemeMode.dark;
        break;
      case AppStrings.lightTheme:
        themeMode.value = ThemeMode.light;
        break;
      default:
        themeMode.value = ThemeMode.system;
    }
    // Ensure GetX is aware of the theme at startup
    Get.changeThemeMode(themeMode.value);
  }

// In SettingsController:
  void changeTheme(ThemeMode? mode) {
    if (mode == null) return;
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    switch (mode) {
      case ThemeMode.dark:
        _storage.saveThemeMode(AppStrings.darkTheme);
        break;
      case ThemeMode.light:
        _storage.saveThemeMode(AppStrings.lightTheme);
        break;
      default:
        _storage.saveThemeMode(AppStrings.systemTheme);
    }
  }
}