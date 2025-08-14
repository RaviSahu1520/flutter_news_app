import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/data/models/article.dart';
import 'package:news_feed_app/presentation/controllers/bookmark_controller.dart';
import 'package:news_feed_app/core/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments as Article;
    final bookmarkController = Get.find<BookmarkController>();
    final isBookmarked = bookmarkController.isBookmarked(article);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Detail'),
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            tooltip: isBookmarked ? 'Remove Bookmark' : 'Add Bookmark',
            onPressed: () {
              bookmarkController.toggleBookmark(article);
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: AppStrings.share,
            onPressed: () => Share.share(article.url),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (article.urlToImage.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.urlToImage,
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
                errorBuilder: (_, __, ___) => const SizedBox(height: 220),
              ),
            ),
          const SizedBox(height: 16),
          Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          Text(
            article.source +
                " • " +
                DateFormat.yMMMd().format(DateTime.parse(article.publishedAt)),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Text(article.description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Share.share(article.url),
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Open in Browser'),
          ),
        ],
      ),
    );
  }
}