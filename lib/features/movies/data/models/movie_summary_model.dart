import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_summary_model.g.dart';

@JsonSerializable()
class MovieSummaryModel {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime releaseDate;
  final List<int> genreIds;
  final bool adult;

  MovieSummaryModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
    required this.adult,
  });

  factory MovieSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MovieSummaryModelFromJson(json);

  MovieSummaryModel copyWith({
    int? id,
    String? title,
    String? posterPath,
    double? voteAverage,
    DateTime? releaseDate,
    List<int>? genreIds,
    bool? adult,
  }) {
    return MovieSummaryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
      genreIds: genreIds ?? this.genreIds,
      adult: adult ?? this.adult,
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
