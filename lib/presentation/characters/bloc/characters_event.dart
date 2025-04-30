part of 'characters_bloc.dart';

abstract class CharacterEvent {}

class LoadCharacters extends CharacterEvent {
  final bool loadMore;

  LoadCharacters({this.loadMore = false});
}
