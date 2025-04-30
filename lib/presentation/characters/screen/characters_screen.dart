import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';
import 'package:test_zadanie/data/models/character_model.dart';
import 'package:provider/provider.dart';  // Для использования Provider

import '../../../data/database/database.dart';
import '../../favorites/model/favorite_model.dart';  // Сюда добавляется логика избранных персонажей

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(LoadCharacters());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        context.read<CharacterBloc>().add(LoadCharacters(loadMore: true));
      }
    });
  }

  // Функция добавления в избранные
  _addToFavorites(CharacterModel character) {
    context.read<FavoritesModel>().addToFavorites(character); // Добавляем в избранное через Provider
  }

  // Функция удаления из избранных
  _removeFromFavorites(CharacterModel character) {
    context.read<FavoritesModel>().removeFromFavorites(character); // Удаляем из избранного
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCharacterCard(CharacterModel character) {
    final isFavorite = context.watch<FavoritesModel>().favorites.contains(character);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            character.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(character.name),
        subtitle: Text('${character.status} - ${character.species}'),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : null,
          ),
          onPressed: () {
            if (isFavorite) {
              context.read<FavoritesModel>().removeFromFavorites(character);
            } else {
              context.read<FavoritesModel>().addToFavorites(character);
            }
          },
        ),
      ),
    );
  }


  Widget _buildCharacterList(List<CharacterModel> characters, {required bool hasMore}) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: characters.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < characters.length) {
          return _buildCharacterCard(characters[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Персонажи')),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          switch (state) {
            case CharactersLoading():
              return _buildCharacterList(state.characters, hasMore: true);
            case CharactersSuccess():
              return _buildCharacterList(state.characters, hasMore: state.hasMore);
            case CharactersError():
              return Center(child: Text('Ошибка: ${state.message}'));
            case CharactersInitial():
              return const Center(child: CircularProgressIndicator());
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
