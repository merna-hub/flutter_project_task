import 'package:flutter/material.dart';
import 'package:flutter_project_task/data/model/product_model.dart';
import 'package:flutter_project_task/data/serviecs/fetch_api.dart';

class ProductController with ChangeNotifier {
 final ApiService _apiService = ApiService();

 List<Product> _products = [];
 List<String> _categories = [];

 bool _isLoading = false;
 String? _errorMessage;

 List<Product> get products => _products;
 List<String> get categories => _categories;
 bool get isLoading => _isLoading;
 String? get errorMessage => _errorMessage;

 Future<void> getProducts() async {
   _isLoading = true;
   notifyListeners();
   try{
      _products = await _apiService.fetchProducts();
      _errorMessage = null;
   }catch(e){
  _errorMessage = e.toString();
   }
   _isLoading = false;
    notifyListeners();
 }


 Future<void> getCategories() async {
   _isLoading = true;
   notifyListeners();
   try{
     _categories = await _apiService.fetchCategories();
     _errorMessage = null;
   }catch(e){
     _errorMessage = e.toString();
   }
   _isLoading = false;
   notifyListeners();
 }
}