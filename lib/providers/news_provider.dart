import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

 
  Future<void> loadHeadlines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchHeadlines();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

 
  Future<void> loadByCategory(String category) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchByCategory(category);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  
  Future<void> search(String keyword) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.searchArticles(keyword);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
