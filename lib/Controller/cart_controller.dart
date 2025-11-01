import 'package:flutter/material.dart';
import 'package:flutter_project_task/data/model/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

}
