part of 'characters_bloc.dart';

sealed class CharacterState {}

class CharactersInitial extends CharacterState {}

class CharactersLoading extends CharacterState {
  final List<CharacterModel> characters;

  CharactersLoading({required this.characters});
}

class CharactersSuccess extends CharacterState {
  final List<CharacterModel> characters;
  final bool hasMore;

  CharactersSuccess({required this.characters, required this.hasMore});
}

class CharactersError extends CharacterState {
  final String message;

  CharactersError(this.message);
}
