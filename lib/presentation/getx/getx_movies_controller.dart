import 'package:get/get.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

enum GetXMoviesState { initial, loading, loaded, error }

class GetXMoviesController extends GetxController {
  final GetPopularMovies getPopularMovies;
  GetXMoviesController(this.getPopularMovies);

  var state = GetXMoviesState.initial.obs;
  var movies = <Movie>[].obs;
  var error = ''.obs;

  void fetchMovies() async {
    state.value = GetXMoviesState.loading;
    try {
      final result = await getPopularMovies();
      movies.value = result;
      state.value = GetXMoviesState.loaded;
    } catch (e) {
      error.value = e.toString();
      state.value = GetXMoviesState.error;
    }
  }
}
