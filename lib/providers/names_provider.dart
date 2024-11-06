import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/model.dart';

class NameProvider with ChangeNotifier {
  List<NameModel> _names = [];
  List<NameModel> _allNames = [];
  bool _isLoading = false;

  List<NameModel> get names => _names;
  bool get isLoading => _isLoading;

  Future<void> fetchNames(String categoryName) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://etosway.com/islamicName/names.php'),
        body: {
          'categoryName': categoryName,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> namesJson = jsonResponse['names'];
        _names = namesJson.map((json) => NameModel.fromJson(json)).toList();
        _allNames = List.from(_names);
      } else {
        throw Exception('Failed to load names');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchNames(String query) {
    if (query.isEmpty) {
      _names = List.from(_allNames);
    } else {
      _names = _allNames.where((name) {
        return name.nameTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }


  void filterNamesByAlphabet(String alphabet) {
    _names = _allNames.where((name) {
      return name.nameTitle.toUpperCase().startsWith(alphabet.toUpperCase());
    }).toList();
    notifyListeners();
  }
}
