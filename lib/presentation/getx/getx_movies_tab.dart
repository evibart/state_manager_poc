import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasources/tmdb_remote_datasource.dart';
import '../../data/repositories/movie_repository_impl.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../widget/poster_card.dart';
import 'getx_movies_controller.dart';

class GetXMoviesTab extends StatelessWidget {
  const GetXMoviesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      GetXMoviesController(
        GetPopularMovies(
          MovieRepositoryImpl(TMDBRemoteDataSource()),
        ),
      ),
    );

    return Obx(() {
      return Column(
        children: [
          ElevatedButton(
            onPressed: () => controller.fetchMovies(),
            child: Text('Fetch Movies'),
          ),
          if (controller.state.value == GetXMoviesState.loading)
            CircularProgressIndicator(),
          if (controller.state.value == GetXMoviesState.error)
            Text(controller.error.value, style: TextStyle(color: Colors.red)),
          if (controller.state.value == GetXMoviesState.loaded)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return PosterCard(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    title: movie.title,
                  );
                },
              ),
            ),
        ],
      );
    });
  }
}
