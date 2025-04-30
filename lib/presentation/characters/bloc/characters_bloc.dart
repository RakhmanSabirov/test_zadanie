import 'package:bloc/bloc.dart';
import 'package:test_zadanie/domain/usecases/get_characters_use_case.dart';

import '../../../data/models/character_model.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersUseCase getCharactersUseCase;

  int _currentPage = 1;
  bool _hasMore = true;
  final List<CharacterModel> _allCharacters = [];

  CharacterBloc({required this.getCharactersUseCase}) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
  }

  Future<void> _onLoadCharacters(
      LoadCharacters event,
      Emitter<CharacterState> emit,
      ) async {
    if (!_hasMore && event.loadMore) return;

    if (!event.loadMore) {
      emit(CharactersLoading(characters: _allCharacters)); // Передаем уже загруженные персонажи
      _currentPage = 1;
      _allCharacters.clear();
    }

    try {
      final newCharacters = await getCharactersUseCase.execute(page: _currentPage);

      _allCharacters.addAll(newCharacters);
      _hasMore = newCharacters.length == 20; // Обычно 20 элементов на страницу
      _currentPage++;

      emit(CharactersSuccess(characters: _allCharacters, hasMore: _hasMore));
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
