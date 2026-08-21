abstract class MovieGenreRepository {
  Future<Map<int, String>> getMovieGenres({required String language});
}
