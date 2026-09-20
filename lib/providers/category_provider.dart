import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/news_service.dart';

class CategoryProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articlesByCategory = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedCategory = 'general';

  List<Article> get articlesByCategory => _articlesByCategory;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  /// Charger les articles selon la catégorie choisie
  Future<void> loadCategory(String category) async {
    _isLoading = true;
    _selectedCategory = category;
    notifyListeners();

    try {
      _articlesByCategory = await _newsService.fetchByCategory(category);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
