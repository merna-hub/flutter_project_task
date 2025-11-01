import 'dart:convert';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
 static const String baseUrl = "https://fakestoreapi.com";

 Future<List<Product>> fetchProducts() async{
  final response = await http.get(Uri.parse("$baseUrl/products"));
  if(response.statusCode == 200){
   final List data = json.decode(response.body);
   return data.map((e) => Product.fromJson(e)).toList();
  }else{
   throw Exception("Failed to load products");
  }
 }

 Future<List<String>> fetchCategories() async{
 final response = await http.get(Uri.parse("$baseUrl/products/categories"));
  if(response.statusCode == 200){
   final List data = json.decode(response.body);
    return data.map<String>((e) => e.toString()).toList();
  }else{
   throw Exception("Failed to load categories");
  }
 }

}