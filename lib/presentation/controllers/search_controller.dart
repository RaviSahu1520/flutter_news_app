import 'package:get/get.dart';
import 'package:news_feed_app/presentation/controllers/news_controller.dart';
import 'package:news_feed_app/data/storage/local_storage_service.dart';
import 'dart:async';

class SearchController extends GetxController {
  final LocalStorageService _storage = LocalStorageService();
  var searchText = ''.obs;
  var searchHistory = <String>[].obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    searchHistory.assignAll(_storage.getSearchHistory());
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().isNotEmpty) {
        final newsController = Get.find<NewsController>();
        newsController.fetchNews(refresh: true, query: value.trim());
        addToHistory(value.trim());
      }
    });
  }

  void addToHistory(String value) {
    if (value.isEmpty) return;
    searchHistory.remove(value);
    searchHistory.insert(0, value);
    if (searchHistory.length > 10) searchHistory.removeLast();
    _storage.saveSearchHistory(searchHistory);
  }

  void clearHistory() {
    searchHistory.clear();
    _storage.saveSearchHistory([]);
  }

  void clearSearch() {
    searchText.value = '';
  }
}