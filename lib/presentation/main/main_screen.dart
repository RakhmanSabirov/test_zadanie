import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_zadanie/presentation/characters/screen/characters_page.dart';
import 'package:test_zadanie/presentation/characters/screen/characters_screen.dart';
import 'package:test_zadanie/presentation/favorites/screen/favorites_page.dart';
import 'package:test_zadanie/presentation/favorites/screen/favorites_screen.dart';

import '../../core/dependencies/dependency_injection.dart';
import '../characters/bloc/characters_bloc.dart';
import '../favorites/model/favorite_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterBloc>(
          create: (context) => getIt<CharacterBloc>(),
        ),
        ChangeNotifierProvider( create: (context) => FavoritesModel(),),
      ],
      child: Scaffold(
        body: _selectedIndex == 0 ? const CharactersScreen() : FavoriteListScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Все'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Избранные'),
          ],
        ),
      ),
    );
  }
}
