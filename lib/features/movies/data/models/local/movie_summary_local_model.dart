import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:hive_flutter/adapters.dart';

part 'movie_summary_local_model.g.dart';

@HiveType(typeId: 1)
class MovieSummaryLocalModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final double voteAverage;

  @HiveField(4)
  final String releaseDate;

  @HiveField(5)
  final List<int> genreIds;

  @HiveField(6)
  final bool adult;

  MovieSummaryLocalModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
    required this.adult,
  });

  factory MovieSummaryLocalModel.fromDomain(MovieSummary movie) {
    return MovieSummaryLocalModel(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      voteAverage: movie.voteAverage,
      releaseDate: movie.releaseDate,
      genreIds: movie.genreIds,
      adult: movie.adult,
    );
  }

  MovieSummary toDomain() {
    return MovieSummary(
      id: id,
      title: title,
      posterPath: posterPath,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      genreIds: genreIds,
      adult: adult,
    );
  }
}
