import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:hive_flutter/adapters.dart';

part 'movie_local_model.g.dart';

@HiveType(typeId: 0)
class MovieLocalModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  final String posterPath;

  @HiveField(4)
  final String backdropPath;

  @HiveField(5)
  final double voteAverage;

  @HiveField(6)
  final int voteCount;

  @HiveField(7)
  final String releaseDate;

  @HiveField(8)
  final List<(int, String)> genres;

  @HiveField(9)
  final String originalLanguage;

  @HiveField(10)
  final double popularity;

  @HiveField(11)
  final bool adult;

  MovieLocalModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genres,
    required this.originalLanguage,
    required this.popularity,
    required this.adult,
  });

  factory MovieLocalModel.fromDomain(Movie movie) {
    return MovieLocalModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      voteAverage: movie.voteAverage,
      releaseDate: movie.releaseDate,
      voteCount: movie.voteCount,
      genres: movie.genres,
      originalLanguage: movie.originalLanguage,
      popularity: movie.popularity,
      adult: movie.adult,
    );
  }

  Movie toDomain() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      voteCount: voteCount,
      genres: genres,
      originalLanguage: originalLanguage,
      popularity: popularity,
      adult: adult,
    );
  }

  MovieSummary toMovieSummary() {
    return MovieSummary(
      id: id,
      title: title,
      posterPath: posterPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      genreIds: genres.map((x) => x.$1).toList(),
      adult: adult,
    );
  }
}
