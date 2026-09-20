import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:news_app/main.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/providers/favorites_provider.dart';
import 'package:news_app/providers/news_provider.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final tempDir = await Directory.systemTemp.createTemp('hive_test_');
    Hive.init(tempDir.path);
    await Hive.openBox('favorites');
    await Hive.openBox('preferences');
    await Hive.openBox('cache');
  });

  test('Article can be converted to and from JSON safely', () {
    final article = Article(
      title: 'Titre test',
      description: 'Description test',
      url: 'https://example.com/article',
      urlToImage: 'https://example.com/image.jpg',
      source: 'Example News',
      publishedAt: DateTime(2024, 1, 1),
      category: 'technology',
    );

    final json = article.toJson();
    final decoded = Article.fromJson(json);

    expect(json['title'], 'Titre test');
    expect(decoded.title, 'Titre test');
    expect(decoded.source, 'Example News');
  });

  testWidgets('App launches with main navigation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NewsProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('NewsApp'), findsOneWidget);
    expect(find.text('Accueil'), findsOneWidget);
  });
}
