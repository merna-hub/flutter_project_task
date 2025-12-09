import 'package:flutter/material.dart';

class SearchControllerProvider extends ChangeNotifier {
  String query = "";

  void updateQuery(String value) {
    query = value;
    notifyListeners();
  }

  void clear() {
    query = "";
    notifyListeners();
  }
}
