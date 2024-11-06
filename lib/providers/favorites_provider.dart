import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/model.dart';

class FavoritesProvider with ChangeNotifier {
  List<String> _favorites = [];

   List<String> get favorites => _favorites;

   FavoritesProvider() {
    _loadFavorites();
  }

  bool isFavorite(NameModel name) {
    return _favorites.contains(name.nameTitle);
  }

  void addToFavorites(NameModel name) {
    if (!_favorites.contains(name.nameTitle)) {
      _favorites.add(name.nameTitle);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(NameModel name) {
    _favorites.remove(name.nameTitle);
    _saveFavorites();
    notifyListeners();
  }


  void removeFromFavoritesByTitle(String nameTitle) {
    _favorites.remove(nameTitle);
    _saveFavorites();
    notifyListeners();
  }


  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setStringList('favorites', _favorites);
    if (success) {
      print("Favorites saved: $_favorites");
    } else {
      print("Failed to save favorites.");
    }
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedFavorites = prefs.getStringList('favorites');

    if (storedFavorites != null) {
      _favorites = storedFavorites;
      print("Favorites loaded: $_favorites");
    } else {
      print("No favorites found in SharedPreferences.");
    }

    notifyListeners();
  }

}
