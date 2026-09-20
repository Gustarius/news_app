import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/article.dart';

class FavoritesProvider with ChangeNotifier {
  final Box _favoritesBox = Hive.box('favorites');

  List<Article> _favorites = [];

  List<Article> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  /// Charger les favoris depuis Hive
  void loadFavorites() {
    final stored = _favoritesBox.values.toList();
    _favorites = stored
        .whereType<Map>()
        .map((json) => Article.fromJson(Map<String, dynamic>.from(json)))
        .toList();
    notifyListeners();
  }

  /// Ajouter un article aux favoris
  void addFavorite(Article article) {
    _favoritesBox.put(article.url, article.toJson());
    loadFavorites();
  }

  /// Supprimer un article des favoris
  void removeFavorite(Article article) {
    _favoritesBox.delete(article.url);
    loadFavorites();
  }

  /// Vérifier si un article est favori
  bool isFavorite(Article article) {
    return _favoritesBox.containsKey(article.url);
  }
}
