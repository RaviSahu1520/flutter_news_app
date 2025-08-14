import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/presentation/controllers/bookmark_controller.dart';
import 'package:news_feed_app/presentation/widgets/article_tile.dart';
import 'package:news_feed_app/core/constants.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarkController = Get.find<BookmarkController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookmarks),
      ),
      body: Obx(() {
        final bookmarks = bookmarkController.bookmarks;
        if (bookmarks.isEmpty) {
          return const Center(child: Text('No bookmarks yet.'));
        }
        return ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, idx) => ArticleTile(article: bookmarks[idx]),
        );
      }),
    );
  }
}