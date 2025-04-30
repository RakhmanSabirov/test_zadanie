import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/favorite_model.dart';

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Избранные персонажи')),
      body: Consumer<FavoritesModel>(  // Слушаем изменения в FavoritesModel
        builder: (context, favoritesModel, child) {
          final favorites = favoritesModel.favorites;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final character = favorites[index];
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
                    icon: Icon(Icons.favorite,color: Colors.red,),
                    onPressed: () => favoritesModel.removeFromFavorites(character),  // Удаляем из избранного
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
