import 'package:get/get.dart';
import 'package:news_feed_app/data/models/article.dart';
import 'package:news_feed_app/data/repositories/news_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_feed_app/core/constants.dart';

enum NewsStatus { loading, success, error, empty, offline }

class NewsController extends GetxController {
  final NewsRepository _repository = NewsRepository();

  var articles = <Article>[].obs;
  var status = NewsStatus.loading.obs;
  var errorMessage = ''.obs;
  var page = 1;
  var hasMore = true.obs;
  var isPaginating = false.obs;
  var currentQuery = AppStrings.defaultQuery.obs;
  final _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    fetchNews(refresh: true);
  }

  Future<void> fetchNews({bool refresh = false, String? query}) async {
    if (refresh) {
      page = 1;
      articles.clear();
      hasMore.value = true;
      status.value = NewsStatus.loading;
      currentQuery.value = query ?? AppStrings.defaultQuery;
    }
    if (status.value == NewsStatus.offline) status.value = NewsStatus.loading;
    try {
      final connection = await _connectivity.checkConnectivity();
      final isOnline = connection != ConnectivityResult.none;
      if (!isOnline) {
        final cached = _repository.getCachedArticles();
        if (cached.isNotEmpty) {
          articles.assignAll(cached);
          status.value = NewsStatus.offline;
        } else {
          status.value = NewsStatus.error;
          errorMessage.value = AppStrings.noInternet;
        }
        return;
      }

      if (!refresh) isPaginating.value = true;
      final result = await _repository.fetchNews(
        query: currentQuery.value,
        page: page,
      );
      if (result.isEmpty && page == 1) {
        status.value = NewsStatus.empty;
      } else {
        if (refresh) {
          articles.assignAll(result);
        } else {
          articles.addAll(result);
        }
        hasMore.value = result.length == AppStrings.articlesPerPage;
        if (hasMore.value) page++;
        status.value = NewsStatus.success;
      }
    } catch (e) {
      status.value = NewsStatus.error;
      errorMessage.value = e.toString();
    } finally {
      isPaginating.value = false;
    }
  }

  void loadMore() {
    if (hasMore.value && !isPaginating.value) {
      fetchNews();
    }
  }
}