class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final DateTime releaseDate;
  final List<({int id, String name})> genres;
  final String originalLanguage;
  final double popularity;
  final int runtime;
  final String? trailerPath;

  Movie({
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
    required this.runtime,
    required this.trailerPath,
  });
}
