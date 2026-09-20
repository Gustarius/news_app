import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favoris")),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text("Aucun article enregistré pour le moment."),
            )
          : ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final article = provider.favorites[index];
                return ListTile(
                  leading: article.urlToImage.isNotEmpty
                      ? Image.network(
                          article.urlToImage,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image),
                  title: Text(article.title),
                  subtitle: Text(article.source),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => provider.removeFavorite(article),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
