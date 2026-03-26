import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final List<(int, String)> genres;
  final String originalLanguage;
  final double popularity;
  final bool adult;

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
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      releaseDate: json['release_date'],
      genres: List<(int, String)>.from(
        json['genres'].map((x) => (x['id'], x['name'])),
      ),
      originalLanguage: json['original_language'],
      popularity: json['popularity'],
      adult: json['adult'],
    );
  }

  MovieModel copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
    String? backdropPath,
    double? voteAverage,
    int? voteCount,
    String? releaseDate,
    List<(int, String)>? genres,
    String? originalLanguage,
    double? popularity,
    bool? adult,
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
      voteCount: voteCount,
      releaseDate: releaseDate,
      genres: genres,
      originalLanguage: originalLanguage,
      popularity: popularity,
      adult: adult,
    );
  }

  MovieSummaryModel toMovieSummaryModel() {
    return MovieSummaryModel(
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
