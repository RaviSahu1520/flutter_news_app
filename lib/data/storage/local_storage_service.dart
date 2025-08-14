import 'package:get_storage/get_storage.dart';
import 'package:news_feed_app/data/models/article.dart';
import 'package:news_feed_app/core/constants.dart';

class LocalStorageService {
  final GetStorage _box = GetStorage();

  void cacheArticles(List<Article> articles) {
    _box.write(AppStorageKeys.cachedArticles, Article.encode(articles));
    _box.write(AppStorageKeys.cachedAt, DateTime.now().toIso8601String());
  }

  List<Article> getCachedArticles() {
    final data = _box.read(AppStorageKeys.cachedArticles);
    if (data != null) {
      return Article.decode(data);
    }
    return [];
  }

  DateTime? getCacheTime() {
    final cachedAt = _box.read(AppStorageKeys.cachedAt);
    if (cachedAt != null) return DateTime.tryParse(cachedAt);
    return null;
  }

  void saveBookmarks(List<Article> articles) {
    _box.write(AppStorageKeys.bookmarks, Article.encode(articles));
  }

  List<Article> getBookmarks() {
    final data = _box.read(AppStorageKeys.bookmarks);
    if (data != null) return Article.decode(data);
    return [];
  }

  void saveSearchHistory(List<String> history) {
    _box.write(AppStorageKeys.searchHistory, history);
  }

  List<String> getSearchHistory() {
    final data = _box.read(AppStorageKeys.searchHistory);
    return (data as List?)?.cast<String>() ?? [];
  }

  void saveThemeMode(String mode) {
    _box.write(AppStorageKeys.themeMode, mode);
  }

  String? getThemeMode() {
    return _box.read(AppStorageKeys.themeMode);
  }
}