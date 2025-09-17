import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class TMDBRemoteDataSource {
  static final String apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  static const String apiUrl = 'https://api.themoviedb.org/3/movie/popular';

  Future<List<MovieModel>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$apiUrl?api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
}