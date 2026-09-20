class Article {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String source;
  final DateTime publishedAt;
  final String category;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.source,
    required this.publishedAt,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'source': source,
      'publishedAt': publishedAt.toIso8601String(),
      'category': category,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    final sourceValue = json['source'];
    String sourceName = '';

    if (sourceValue is Map<String, dynamic>) {
      sourceName = sourceValue['name']?.toString() ?? '';
    } else if (sourceValue is String) {
      sourceName = sourceValue;
    }

    final categoryValue = json['category']?.toString() ?? '';
    final publishedAt = json['publishedAt'] is String
        ? DateTime.tryParse(json['publishedAt'] as String) ?? DateTime.now()
        : DateTime.now();

    return Article(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      urlToImage: json['urlToImage']?.toString() ?? '',
      source: sourceName,
      publishedAt: publishedAt,
      category: categoryValue,
    );
  }
}
