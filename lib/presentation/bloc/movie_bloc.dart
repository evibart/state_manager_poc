import 'dart:async';


import '../../core/utils/status.dart';
import '../../domain/entities/data.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

class MovieBloc {
  final GetPopularMovies moviesUseCase;
  final StreamController<Data<List<Movie>>> _movieListController =
  StreamController<Data<List<Movie>>>.broadcast();

  MovieBloc({required this.moviesUseCase});

  Data<List<Movie>> get initialData => Data<List<Movie>>(state: Status.loading);

  Stream<Data<List<Movie>>> get movieListStream => _movieListController.stream;

  void fetchMovies() async {
    _movieListController.sink.add(Data(state: Status.loading));
    try {
      final List<Movie> movies = await moviesUseCase.call();
      if (movies.isEmpty) {
        _movieListController.sink.add(
          Data(state: Status.empty),
        );
      } else {
        _movieListController.sink.add(
          Data(state: Status.success, actualData: movies),
        );
      }
    } catch (e) {
      _movieListController.sink.add(
        Data(state: Status.failed, error: e.toString()),
      );
    }
  }


  void dispose() {
    _movieListController.close();
  }
}
