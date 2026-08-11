import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';

abstract class MovieRepository {
  Future<List<MovieSummary>> fetchPopularMovies({
    int page = 1,
    List<int> genreIds = const [],
  });
  Future<List<MovieSummary>> fetchTopRatedMovies({
    int page = 1,
    List<int> genreIds = const [],
  });
  Future<List<MovieSummary>> fetchUpcomingMovies({
    int page = 1,
    List<int> genreIds = const [],
  });
  Future<List<MovieSummary>> searchMovie({required String query, int page = 1});
  Future<Movie> fetchMovieById({required int id});
  Future<List<MovieSummary>> fetchSimilarMovies({
    required int id,
    int page = 1,
  });

  Future<void> addFavorite(int id);
  Future<void> removeFavorite(int id);
  bool isFavorite(int id);
  Future<List<MovieSummary>> fetchFavoriteMovies({
    int page = 1,
    List<int> genreIds = const [],
  });

  Future<void> addToWatchList(int id);
  Future<void> removeFromWatchList(int id);
  bool isInWatchList(int id);
  Future<List<MovieSummary>> fetchWatchListMovies({
    int page = 1,
    List<int> genreIds = const [],
  });
}
