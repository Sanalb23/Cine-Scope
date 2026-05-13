class MovieSummary {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final DateTime releaseDate;
  final List<int> genreIds;

  MovieSummary({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genreIds,
  });
}
