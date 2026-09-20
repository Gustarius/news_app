import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';

class NewsService {
  final String apiKey = 'd3cf2ee4c49b4b978abab588b729b34c';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<Article>> fetchHeadlines() async {
    final url = Uri.parse(
      '$baseUrl/top-headlines?country=us&apiKey=${Uri.encodeQueryComponent(apiKey)}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = (data['articles'] as List?) ?? const [];
      return articles
          .map(
            (json) => Article.fromJson({
              ...Map<String, dynamic>.from(json as Map),
              'category': 'general',
            }),
          )
          .toList();
    }

    throw Exception('Erreur lors de la récupération des headlines');
  }

  Future<List<Article>> fetchByCategory(String category) async {
    final url = Uri.parse(
      '$baseUrl/top-headlines?category=${Uri.encodeQueryComponent(category)}&country=us&apiKey=${Uri.encodeQueryComponent(apiKey)}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = (data['articles'] as List?) ?? const [];
      return articles
          .map(
            (json) => Article.fromJson({
              ...Map<String, dynamic>.from(json as Map),
              'category': category,
            }),
          )
          .toList();
    }

    throw Exception(
      'Erreur lors de la récupération des articles par catégorie',
    );
  }

  Future<List<Article>> searchArticles(String keyword) async {
    final query = Uri.encodeQueryComponent(keyword.trim());
    final url = Uri.parse(
      '$baseUrl/everything?q=$query&apiKey=${Uri.encodeQueryComponent(apiKey)}',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = (data['articles'] as List?) ?? const [];
      return articles
          .map(
            (json) => Article.fromJson({
              ...Map<String, dynamic>.from(json as Map),
              'category': 'search',
            }),
          )
          .toList();
    }

    throw Exception('Erreur lors de la recherche d’articles');
  }
}
