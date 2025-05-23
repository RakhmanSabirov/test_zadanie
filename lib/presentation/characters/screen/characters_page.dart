import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_zadanie/core/dependencies/dependency_injection.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';
import 'package:test_zadanie/presentation/favorites/cubit/favorites_cubit.dart';
import '../../favorites/model/favorite_model.dart';
import 'characters_screen.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) => getIt<CharacterBloc>(),
        ),
        ChangeNotifierProvider( create: (context) => FavoritesModel(),),
      ],
      child: const CharactersScreen(),
    );
  }
}
