import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/tmdb_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final TMDBRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getPopularMovies() {
    return remoteDataSource.fetchPopularMovies();
  }
}
