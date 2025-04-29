import 'package:dio/dio.dart';

import '../models/character_model.dart';

class CharacterDataSource {
  final Dio dio;

  CharacterDataSource(this.dio);

  Future<List<CharacterModel>> getCharacters() async {
    final response = await dio.get('https://rickandmortyapi.com/api/character');
    return (response.data as List)
        .map((json) => CharacterModel.fromJson(json))
        .toList();
  }

}
