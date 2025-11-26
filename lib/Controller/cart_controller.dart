import 'package:flutter/material.dart';
import '../data/model/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> _items = {}; // key: product.id

  Map<int, CartItem> get items => _items;

  List<CartItem> get cartItems => _items.values.toList();

  double get totalPrice {
    double total = 0;
    _items.forEach((key, item) {
      total += item.product.price * item.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
      notifyListeners();
    }
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void decreaseQuantity(Product product) {
    if (_items.containsKey(product.id)) {
      if (_items[product.id]!.quantity > 1) {
        _items[product.id]!.quantity -= 1;
      } else {
        _items.remove(product.id);
      }
      notifyListeners();
    }
  }
}
