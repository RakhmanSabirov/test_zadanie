import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_zadanie/core/dependencies/dependency_injection.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';
import 'package:test_zadanie/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:test_zadanie/presentation/favorites/screen/favorites_screen.dart';
import '../../favorites/model/favorite_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( create: (context) => FavoritesModel(),
      child: FavoriteListScreen(),
    );
  }
}
