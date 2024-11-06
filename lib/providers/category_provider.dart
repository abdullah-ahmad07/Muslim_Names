import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoadingCategories = false;

  List<Category> get categories => _categories;
  bool get isLoadingCategories => _isLoadingCategories;

  Future<void> fetchCategories() async {
    _isLoadingCategories = true;
    notifyListeners();

    const url = 'https://etosway.com/islamicName/categories.php';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _categories = data.map((category) => Category.fromJson(category)).toList();
      }
    } catch (error) {
      throw Exception('Failed to load categories');
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }
}


