import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(createToJson: false)
class MovieModel {
  final int id;
  final String title;
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'vote_average')
  final double voteAverage;

  @JsonKey(name: 'vote_count')
  final int voteCount;

  @JsonKey(name: 'release_date')
  final DateTime releaseDate;

  final List<({int id, String name})> genres;

  @JsonKey(name: 'original_language')
  final String originalLanguage;

  final double popularity;
  final bool adult;
  final int runtime;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? trailerPath;

  MovieModel({
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
    required this.runtime,
    this.trailerPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  MovieModel copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    int? voteCount,
    DateTime? releaseDate,
    List<({int id, String name})>? genres,
    String? originalLanguage,
    double? popularity,
    bool? adult,
    int? runtime,
    String? trailerPath,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      releaseDate: releaseDate ?? this.releaseDate,
      genres: genres ?? this.genres,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      popularity: popularity ?? this.popularity,
      adult: adult ?? this.adult,
      runtime: runtime ?? this.runtime,
      trailerPath: trailerPath ?? this.trailerPath,
    );
  }

  Movie toDomain() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      genres: genres,
      originalLanguage: originalLanguage,
      popularity: popularity,
      adult: adult,
      runtime: runtime,
      trailerPath: trailerPath,
    );
  }

  MovieSummaryModel toMovieSummaryModel() {
    return MovieSummaryModel(
      id: id,
      title: title,
      posterPath: posterPath ?? '',
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      genreIds: genres.map((x) => x.id).toList(),
      adult: adult,
    );
  }
}
