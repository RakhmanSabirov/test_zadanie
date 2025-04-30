import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';
import 'package:test_zadanie/data/models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCharacterCard(CharacterModel character) {
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
        trailing: const Icon(Icons.star_border),
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
          }
        },
      ),
    );
  }
}
