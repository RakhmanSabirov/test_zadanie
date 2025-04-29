import 'package:test_zadanie/data/models/character_model.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getCharacters();
}
