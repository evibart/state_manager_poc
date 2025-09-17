import 'package:flutter/material.dart';
import '../../core/utils/status.dart';
import '../../data/datasources/tmdb_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/entities/data.dart';
import '../../domain/entities/movie.dart';
import '../widget/poster_card.dart';
import 'movie_bloc.dart';

class MovieBlocTab extends StatefulWidget {
  const MovieBlocTab({super.key});

  @override
  State<MovieBlocTab> createState() => _MovieBlocTabState();
}

class _MovieBlocTabState extends State<MovieBlocTab> {
  late MovieBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc(
      moviesUseCase: GetPopularMovies(
        MovieRepositoryImpl(TMDBRemoteDataSource()),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => bloc.fetchMovies(),
          child: Text('Fetch Movies'),
        ),
        Expanded(
          child: StreamBuilder<Data<List<Movie>>>(
            stream: bloc.movieListStream,
            initialData: bloc.initialData,
            builder: (context, snapshot) {
              final data = snapshot.data!;
              switch (data.state) {
                case Status.loading:
                  return Center(child: CircularProgressIndicator());
                case Status.success:
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: data.actualData?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemBuilder: (context, index) {
                      final movie = data.actualData![index];
                      return PosterCard(
                        imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        title: movie.title,
                      );
                    },
                  );
                case Status.empty:
                  return Center(child: Text('No movies found'));
                case Status.failed:
                  return Center(child: Text('Error: ${data.error}', style: TextStyle(color: Colors.red)));
              }
            },
          ),
        ),
      ],
    );
  }
}
