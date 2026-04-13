import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';

abstract class MovieRepository {
  Future<List<MovieSummary>> getPopularMovies({int page = 1});
  Future<List<MovieSummary>> getTopRatedMovies({int page = 1});
  Future<List<MovieSummary>> searchMovie({required String query, int page = 1});
  Future<Movie> getMovieById({required int id});
  Future<List<MovieSummary>> getSimilarMovies({required int id, int page = 1});

  Future<void> addFavorite(int id);
  Future<void> removeFavorite(int id);
  bool isFavorite(int id);
  Future<List<MovieSummary>> getFavoriteMovies({int page = 1});

  Future<void> addToWatchList(int id);
  Future<void> removeFromWatchList(int id);
  bool isInWatchList(int id);
  Future<List<MovieSummary>> getWatchListMovies({int page = 1});
}
