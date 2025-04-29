part of 'characters_bloc.dart';

abstract class CharactersEvent {}

class FetchCharactersEvent extends CharactersEvent {}

class LoadNextPageEvent extends CharactersEvent {}
