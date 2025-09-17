import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/poster_card.dart';
import 'riverpod_movies_provider.dart';

class RiverpodMoviesTab extends ConsumerWidget {
  const RiverpodMoviesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(riverpodMoviesProvider);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () => ref.read(riverpodMoviesProvider.notifier).fetchMovies(),
          child: const Text('Fetch Movies'),
        ),
        Expanded(
          child: moviesAsync.when(
            data: (movies) {
              if (movies.isEmpty) {
                return const Center(child: Text("No movies yet"));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return PosterCard(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    title: movie.title,
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text(e.toString(), style: const TextStyle(color: Colors.red))),
          ),
        ),
      ],
    );
  }
}
