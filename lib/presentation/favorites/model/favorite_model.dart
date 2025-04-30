import 'package:flutter/cupertino.dart';
import '../../../data/models/character_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesModel extends ChangeNotifier {
  List<CharacterModel> _favorites = [];

  List<CharacterModel> get favorites => _favorites;

  FavoritesModel() {
    _loadFavorites();
  }

  // Загружаем избранных персонажей из SharedPreferences
  _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');
    if (favoritesJson != null) {
      final List<dynamic> decodedList = jsonDecode(favoritesJson);
      _favorites = decodedList.map((e) => CharacterModel.fromJson(e)).toList();
      notifyListeners();
    }
  }

  // Сохраняем избранных персонажей в SharedPreferences
  _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String favoritesJson = jsonEncode(_favorites.map((e) => e.toJson()).toList());
    prefs.setString('favorites', favoritesJson);
  }

  // Добавляем персонажа в избранное
  addToFavorites(CharacterModel character) {
    if (!_favorites.contains(character)) {
      _favorites.add(character);
      _saveFavorites();
      notifyListeners();
    }
  }

  // Удаляем персонажа из избранного
  removeFromFavorites(CharacterModel character) {
    _favorites.remove(character);
    _saveFavorites();
    notifyListeners();
  }
}
