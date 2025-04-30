import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesCubit extends Cubit<List<int>> {
  FavoritesCubit() : super([]);

  // Метод для получения списка избранных из SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    emit(favoriteIds.map((id) => int.parse(id)).toList());
  }

  // Метод для добавления/удаления персонажа из избранных
  void toggleFavorite(int characterId) async {
    final currentFavorites = List<int>.from(state);
    if (currentFavorites.contains(characterId)) {
      currentFavorites.remove(characterId);
    } else {
      currentFavorites.add(characterId);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_ids', currentFavorites.map((id) => id.toString()).toList());

    emit(currentFavorites); // Обновляем состояние
  }

  // Проверка, является ли персонаж в избранных
  bool isFavorite(int characterId) {
    return state.contains(characterId);
  }
}


