import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({required super.id, required super.title, required super.posterPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json['id'],
    title: json['title'],
    posterPath: json['poster_path'] ?? '',
  );
}