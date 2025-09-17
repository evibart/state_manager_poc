import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/tmdb_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

class RiverpodMoviesNotifier extends StateNotifier<AsyncValue<List<Movie>>> {
  final GetPopularMovies getPopularMovies;

  RiverpodMoviesNotifier(this.getPopularMovies) : super(const AsyncValue.data([]));

  Future<void> fetchMovies() async {
    state = const AsyncValue.loading();
    try {
      final movies = await getPopularMovies();
      state = AsyncValue.data(movies);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final riverpodMoviesProvider = StateNotifierProvider<RiverpodMoviesNotifier, AsyncValue<List<Movie>>>(
      (ref) => RiverpodMoviesNotifier(
    GetPopularMovies(
      MovieRepositoryImpl(TMDBRemoteDataSource()),
    ),
  ),
);
