import 'package:flutter/material.dart';
import '../data/model/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  bool isFavorite(Product product) {
    return _favoriteItems.any((item) => item.id == product.id);
  }

  void toggleFavorite(Product product) {
    final existingIndex =
    _favoriteItems.indexWhere((item) => item.id == product.id);

    if (existingIndex >= 0) {
      _favoriteItems.removeAt(existingIndex);
    } else {
      _favoriteItems.add(product);
    }
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favoriteItems.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }
}
