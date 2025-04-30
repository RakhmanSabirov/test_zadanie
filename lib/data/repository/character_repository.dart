import 'package:test_zadanie/data/data_source/character_data_source.dart';
import 'package:test_zadanie/data/models/character_model.dart';

import '../../domain/repository/character_repository.dart';


class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDataSource dataSource;

  CharacterRepositoryImpl(this.dataSource);

  @override
  Future<List<CharacterModel>> getCharacters({required int page}) {
    return dataSource.getCharacters(page: page);
  }
}
