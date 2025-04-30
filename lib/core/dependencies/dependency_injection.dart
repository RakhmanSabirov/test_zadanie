import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:test_zadanie/data/data_source/character_data_source.dart';
import 'package:test_zadanie/data/repository/character_repository.dart';
import 'package:test_zadanie/domain/repository/character_repository.dart';
import 'package:test_zadanie/domain/usecases/get_characters_use_case.dart';
import 'package:test_zadanie/presentation/favorites/cubit/favorites_cubit.dart';

import '../../presentation/characters/bloc/characters_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => CharacterDataSource(getIt()));

  getIt
      .registerLazySingleton<CharacterRepository>(() => CharacterRepositoryImpl(getIt()));

  getIt.registerLazySingleton(() => GetCharactersUseCase(getIt()));

  getIt.registerFactory(() => CharacterBloc(
    getCharactersUseCase: getIt(),
  ));
  getIt.registerFactory(() => FavoritesCubit());
}
