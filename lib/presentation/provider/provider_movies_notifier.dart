import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

enum ProviderMoviesState { initial, loading, loaded, error }

class ProviderMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;
  ProviderMoviesNotifier(this.getPopularMovies);

  ProviderMoviesState state = ProviderMoviesState.initial;
  List<Movie> movies = [];
  String? error;

  Future<void> fetchMovies() async {
    state = ProviderMoviesState.loading;
    notifyListeners();
    try {
      movies = await getPopularMovies();
      state = ProviderMoviesState.loaded;
    } catch (e) {
      error = e.toString();
      state = ProviderMoviesState.error;
    }
    notifyListeners();
  }
}
