import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/favorite_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context); // listen: true
    final favorites = favoriteProvider.favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return ListTile(
            leading: Image.network(product.image, width: 50),
            title: Text(product.title),
            subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                favoriteProvider.removeFavorite(product);
              },
            ),
          );
        },
      ),
    );
  }
}
