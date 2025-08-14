import 'package:get/get.dart';
import 'package:news_feed_app/presentation/screens/detail_screen.dart';
import 'package:news_feed_app/presentation/screens/settings_screen.dart';

import '../screens/bookmark_screen.dart';
import '../screens/home_screens.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final pages = [
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.detail, page: () => const DetailScreen()),
    GetPage(name: Routes.bookmarks, page: () => const BookmarksScreen()),
    GetPage(name: Routes.settings, page: () => const SettingsScreen()),
  ];
}