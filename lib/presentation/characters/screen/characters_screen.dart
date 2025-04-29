import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zadanie/presentation/characters/bloc/characters_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
    context
        .read<CharactersBloc>()
        .add(FetchCharactersEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_controller.position.extentAfter < 300) {
      context.read<CharactersBloc>().add(
          LoadNextPageEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Персонажи")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                return switch (state) {
                  CharactersLoading() =>
                  const Center(child: CircularProgressIndicator()),
                  CharactersLoaded() ||
                  CharactersLoadingMore() =>
                      Builder(builder: (context) {
                        final characters = (state is CharactersLoaded)
                            ? state.characters
                            : (state as CharactersLoadingMore).characters;
                        final isLoadingMore = state is CharactersLoadingMore;
                        return ListView.builder(
                          controller: _controller,
                          itemCount: characters.length + (isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == characters.length && isLoadingMore) {
                              // Здесь именно posts.length, а не -1
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }

                            final character = characters[index];
                            return Card(
                              child: ListTile(
                                title: Text(character.name),
                                subtitle: Text(
                                  character.gender,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                  CharactersError() =>
                      Center(child: Text("Ошибка: ${state.message}")),
                };
                // if (state is PostsLoading) {
                //   return Center(child: CircularProgressIndicator());
                // } else if (state is PostsLoaded || state is PostsLoadingMore) {
                //   final posts = (state is PostsLoaded) ? state.posts : (state as PostsLoadingMore).posts;
                //   final isLoadingMore = state is PostsLoadingMore;
                //
                //   return ListView.builder(
                //     controller: _controller,
                //     itemCount: posts.length + (isLoadingMore ? 1 : 0),
                //     itemBuilder: (context, index) {
                //       if (index == posts.length && isLoadingMore) { // Здесь именно posts.length, а не -1
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Center(child: CircularProgressIndicator()),
                //         );
                //       }
                //
                //       final post = posts[index];
                //       return Card(
                //         child: ListTile(
                //           title: Text(post.title),
                //           subtitle: Text(
                //             post.content,
                //             maxLines: 2,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //           onTap: () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (_) => PostDetailPage(postId: post.id),
                //               ),
                //             );
                //           },
                //         ),
                //       );
                //     },
                //   );
                // } else if (state is PostsError) {
                //   return Center(child: Text("Ошибка: ${state.message}"));
                // }
                // return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
