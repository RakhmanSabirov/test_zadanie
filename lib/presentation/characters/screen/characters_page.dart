import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zadanie/domain/usecases/get_characters_use_case.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';
import '../../../core/dependencies/dependency_injection.dart';
import 'characters_screen.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        getCharactersUseCase:
        getIt<GetCharactersUseCase>(), // Получаем зависимость через getIt
      ),
      child: const CharactersScreen(),
    );
  }
}
