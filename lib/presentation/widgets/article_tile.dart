import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/data/models/article.dart';
import 'package:intl/intl.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed('/detail', arguments: article),
      leading: article.urlToImage.isNotEmpty
          ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          article.urlToImage,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox(width: 60, height: 60),
        ),
      )
          : const SizedBox(width: 60, height: 60),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${article.source} • ${DateFormat.yMMMd().format(DateTime.parse(article.publishedAt))}\n'
            '${article.description}',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
    );
  }
}