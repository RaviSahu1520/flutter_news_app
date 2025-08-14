import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/presentation/controllers/settings_controller.dart';
import 'package:news_feed_app/core/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: Obx(() => ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(_themeModeText(settingsController.themeMode.value)),
            trailing: DropdownButton<ThemeMode>(
              value: settingsController.themeMode.value,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppStrings.systemTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppStrings.lightTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppStrings.darkTheme),
                ),
              ],
              onChanged: settingsController.changeTheme,
            ),
          ),
        ],
      )),
    );
  }

  String _themeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppStrings.lightTheme;
      case ThemeMode.dark:
        return AppStrings.darkTheme;
      default:
        return AppStrings.systemTheme;
    }
  }
}