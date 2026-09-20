import 'package:hive/hive.dart';
import '../models/user_preference.dart';

class StorageService {
  final Box _prefsBox = Hive.box('preferences');
  final Box _cacheBox = Hive.box('cache');

  /// Sauvegarder les préférences utilisateur
  void savePreferences(UserPreference prefs) {
    _prefsBox.put('userPrefs', prefs.toJson());
  }

  /// Charger les préférences utilisateur
  UserPreference loadPreferences() {
    final data = _prefsBox.get('userPrefs');
    if (data != null) {
      return UserPreference.fromJson(Map<String, dynamic>.from(data));
    }
    return UserPreference(
      favoriteCategories: [],
      darkMode: false,
      language: "fr",
    );
  }

  /// Sauvegarder un article en cache
  void cacheArticle(Map<String, dynamic> articleJson) {
    _cacheBox.put(articleJson['url'], articleJson);
  }

  /// Charger les articles en cache
  List<Map<String, dynamic>> loadCachedArticles() {
    return _cacheBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
