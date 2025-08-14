import 'package:get/get.dart';
import 'package:news_feed_app/data/models/article.dart';
import 'package:news_feed_app/data/storage/local_storage_service.dart';
import 'package:news_feed_app/core/constants.dart';

class BookmarkController extends GetxController {
  final LocalStorageService _storage = LocalStorageService();

  var bookmarks = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  void loadBookmarks() {
    bookmarks.assignAll(_storage.getBookmarks());
  }

  void toggleBookmark(Article article) {
    if (isBookmarked(article)) {
      bookmarks.removeWhere((a) => a.url == article.url);
      Get.snackbar(AppStrings.bookmarks, AppStrings.bookmarkRemoved);
    } else {
      bookmarks.add(article);
      Get.snackbar(AppStrings.bookmarks, AppStrings.bookmarkAdded);
    }
    _storage.saveBookmarks(bookmarks);
  }

  bool isBookmarked(Article article) {
    return bookmarks.any((a) => a.url == article.url);
  }
}