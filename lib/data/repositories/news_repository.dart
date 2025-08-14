import 'package:news_feed_app/data/models/article.dart';
import 'package:news_feed_app/data/services/news_api_service.dart';
import 'package:news_feed_app/data/storage/local_storage_service.dart';
import 'package:news_feed_app/core/constants.dart';

class NewsRepository {
  final NewsApiService api;
  final LocalStorageService storage;

  NewsRepository({NewsApiService? api, LocalStorageService? storage})
      : api = api ?? NewsApiService(),
        storage = storage ?? LocalStorageService();

  Future<List<Article>> fetchNews({required String query, required int page}) async {
    final res = await api.fetchNews(query: query, page: page);
    if (res['status'] == 'ok') {
      final articles = Article.fromJsonList(res['articles']);
      if (page == 1) storage.cacheArticles(articles);
      return articles;
    }
    throw Exception(AppStrings.generalError);
  }

  List<Article> getCachedArticles() {
    return storage.getCachedArticles();
  }

  DateTime? getCacheTime() {
    return storage.getCacheTime();
  }
}