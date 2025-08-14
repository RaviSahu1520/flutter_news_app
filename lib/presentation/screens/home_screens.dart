import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/presentation/controllers/news_controller.dart';
import 'package:news_feed_app/presentation/controllers/search_controller.dart';
import 'package:news_feed_app/presentation/widgets/article_tile.dart';
import 'package:news_feed_app/presentation/widgets/shimmer_loader.dart';
import 'package:news_feed_app/presentation/widgets/empty_view.dart';
import 'package:news_feed_app/presentation/widgets/error_view.dart';
import 'package:news_feed_app/core/constants.dart';

import '../controllers/search_controller.dart' as myapp;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsController = Get.find<NewsController>();
    final searchController = Get.find<myapp.SearchController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
              icon: const Icon(Icons.bookmark),
              tooltip: AppStrings.bookmarks,
              onPressed: () => Get.toNamed('/bookmarks')),
          IconButton(
              icon: const Icon(Icons.settings),
              tooltip: AppStrings.settings,
              onPressed: () => Get.toNamed('/settings')),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Obx(() => TextField(
              onChanged: searchController.onSearchChanged,
              controller: TextEditingController(text: searchController.searchText.value),
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.searchText.value.isNotEmpty
                    ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clearSearch();
                      newsController.fetchNews(refresh: true);
                    })
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )),
          ),
        ),
      ),
      body: Obx(() {
        switch (newsController.status.value) {
          case NewsStatus.loading:
            return const ShimmerLoader();
          case NewsStatus.error:
            return ErrorView(
                message: newsController.errorMessage.value,
                onRetry: () => newsController.fetchNews(refresh: true));
          case NewsStatus.empty:
            return const EmptyView(message: AppStrings.emptyNews);
          case NewsStatus.offline:
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.amber.shade200,
                  padding: const EdgeInsets.all(8),
                  child: const Text(AppStrings.offline, textAlign: TextAlign.center),
                ),
                Expanded(child: _newsList(newsController)),
              ],
            );
          case NewsStatus.success:
            return _newsList(newsController);
        }
      }),
    );
  }

  Widget _newsList(NewsController newsController) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!newsController.isPaginating.value &&
            newsController.hasMore.value &&
            scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50) {
          newsController.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () => newsController.fetchNews(refresh: true),
        child: Obx(() {
          final items = newsController.articles;
          if (items.isEmpty) return const EmptyView(message: AppStrings.emptyNews);
          return ListView.builder(
              itemCount: items.length + (newsController.isPaginating.value ? 1 : 0),
              itemBuilder: (context, idx) {
                if (idx < items.length) {
                  return ArticleTile(article: items[idx]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              });
        }),
      ),
    );
  }
}