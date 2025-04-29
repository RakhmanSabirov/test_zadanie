part of 'characters_bloc.dart';

sealed class CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;
  final bool hasNextPage;

  CharactersLoaded(this.characters, this.hasNextPage);
}

class CharactersLoadingMore extends CharactersState {
  final List<CharacterModel> characters;
  CharactersLoadingMore(this.characters);
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
