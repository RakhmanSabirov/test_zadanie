import 'package:dio/dio.dart';

import '../models/character_model.dart';

class CharacterDataSource {
  final Dio dio;
  int _currentPage = 1;
  bool _hasNextPage = true;

  CharacterDataSource(this.dio);

  Future<List<CharacterModel>> getCharacters({required int page}) async {
    // Если это не подгрузка, сбрасываем текущие параметры
    if (page == 1) {
      _currentPage = 1;
      _hasNextPage = true;
    }

    if (!_hasNextPage) return [];

    final response = await dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: {
        'page': page, // Используем переданный page
      },
    );

    final data = response.data;
    final results = data['results'] as List;
    final info = data['info'];

    // Проверка на следующую страницу
    if (info['next'] == null) {
      _hasNextPage = false;
    } else {
      _currentPage++;
    }

    return results.map((json) => CharacterModel.fromJson(json)).toList();
  }

  void resetPagination() {
    _currentPage = 1;
    _hasNextPage = true;
  }

  bool get hasNextPage => _hasNextPage;
}
