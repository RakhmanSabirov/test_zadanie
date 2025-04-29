
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:test_zadanie/domain/usecases/get_characters_use_case.dart';

import '../../../data/models/character_model.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetCharactersUseCase getCharactersUseCase;
  bool _isFetching = false;
  List<CharacterModel> _allCharacters = [];
  List<CharacterModel> _displayedCharacters = [];
  int _currentPage = 0;
  final int _postsPerPage = 15;

  CharactersBloc({
    required this.getCharactersUseCase,
  }) : super(CharactersLoading()) {
    on<FetchCharactersEvent>(_onFetchCharacters);
    on<LoadNextPageEvent>(_onLoadNextPage);
  }

  Future<void> _onFetchCharacters(
      FetchCharactersEvent event, Emitter<CharactersState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final newCharacters = await getCharactersUseCase.execute();
      print('Fetched ${newCharacters.length} characters from server');

      if (newCharacters.isEmpty) {
        emit(CharactersError('Нет постов для отображения'));
        return;
      }

      _allCharacters = newCharacters;
      _displayedCharacters = _allCharacters.take(_postsPerPage).toList();

      emit(CharactersLoaded(_displayedCharacters,
          _allCharacters.length > _postsPerPage));
      _currentPage++;
    } catch (e) {
      if (e is DioException) {
        emit(CharactersError('Ошибка загрузки постов: ${e.message}'));
      } else {
        emit(CharactersError('Неизвестная ошибка при загрузке постов'));
      }
    }

    _isFetching = false;
  }

  Future<void> _onLoadNextPage(
      LoadNextPageEvent event, Emitter<CharactersState> emit) async {
    if (_isFetching) return;
    if (_currentPage * _postsPerPage >= _allCharacters.length) {
      emit(CharactersLoaded(_displayedCharacters, false));
      return;
    }

    _isFetching = true;

    emit(CharactersLoadingMore(_displayedCharacters));

    await Future.delayed(const Duration(seconds: 1));

    final nextCharacters = _allCharacters
        .skip(_currentPage * _postsPerPage)
        .take(_postsPerPage)
        .toList();
    _displayedCharacters.addAll(nextCharacters);

    final hasNextPage =
        (_currentPage * _postsPerPage + _postsPerPage) < _allCharacters.length;

    emit(CharactersLoaded(_displayedCharacters, hasNextPage));
    _currentPage++;

    _isFetching = false;
  }
}
