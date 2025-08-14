import 'dart:convert';

class Article {
  final String? author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String source;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.source,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      source: json['source']?['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt,
    'source': source,
  };

  static List<Article> fromJsonList(List<dynamic> list) =>
      list.map((e) => Article.fromJson(e)).toList();

  static String encode(List<Article> articles) => json.encode(
    articles.map<Map<String, dynamic>>((a) => a.toJson()).toList(),
  );

  static List<Article> decode(String articles) =>
      (json.decode(articles) as List<dynamic>).map<Article>((item) => Article.fromJson(item)).toList();
}