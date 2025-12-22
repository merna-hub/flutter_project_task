import 'package:flutter/material.dart';
import 'package:flutter_project_task/data/model/product_model.dart';
import 'package:flutter_project_task/data/serviecs/fetch_api.dart';

class ProductController with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> _filteredProducts = []; // For search
  List<String> _categories = [];

  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Product> get products => _filteredProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch products from API
  Future<void> getProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await _apiService.fetchProducts();
      _filteredProducts = _products; // Initialize filtered list
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  // Fetch categories from API
  Future<void> getCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _apiService.fetchCategories();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  // Search products locally
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
