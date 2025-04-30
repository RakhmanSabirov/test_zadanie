
import 'package:test_zadanie/data/models/character_model.dart';
import 'package:test_zadanie/domain/repository/character_repository.dart';

class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase(this.repository);

  Future<List<CharacterModel>> execute({int page = 1}) {
    return repository.getCharacters(page: page);
  }
}
