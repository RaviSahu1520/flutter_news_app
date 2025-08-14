import 'package:get/get.dart';
import 'package:news_feed_app/presentation/controllers/news_controller.dart';
import 'package:news_feed_app/presentation/controllers/search_controller.dart';
import 'package:news_feed_app/presentation/controllers/bookmark_controller.dart';
import 'package:news_feed_app/presentation/controllers/settings_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NewsController>(NewsController(), permanent: true);
    Get.put<SearchController>(SearchController(), permanent: true);
    Get.put<BookmarkController>(BookmarkController(), permanent: true);
    Get.put<SettingsController>(SettingsController(), permanent: true);
  }
}