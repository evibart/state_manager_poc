import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/tmdb_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../widget/poster_card.dart';
import 'provider_movies_notifier.dart';

class ProviderMoviesTab extends StatelessWidget {
  const ProviderMoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProviderMoviesNotifier(
        GetPopularMovies(
          MovieRepositoryImpl(TMDBRemoteDataSource()),
        ),
      ),
      child: Consumer<ProviderMoviesNotifier>(
        builder: (context, model, _) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () => model.fetchMovies(),
                child: Text('Fetch Movies'),
              ),
              if (model.state == ProviderMoviesState.loading)
                CircularProgressIndicator(),
              if (model.state == ProviderMoviesState.error)
                Text(model.error ?? 'Unknown error', style: TextStyle(color: Colors.red)),
              if (model.state == ProviderMoviesState.loaded)
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: model.movies.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final movie = model.movies[index];
                      return PosterCard(
                        imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        title: movie.title,
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
