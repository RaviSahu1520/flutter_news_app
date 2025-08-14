import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/core/constants.dart';
import 'package:news_feed_app/core/themes.dart';
import 'package:news_feed_app/core/bindings/initial_bindings.dart';
import 'package:news_feed_app/presentation/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const NewsFeedApp());
}

class NewsFeedApp extends StatelessWidget {
  const NewsFeedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      smartManagement: SmartManagement.full,
      enableLog: false,
    );
  }
}