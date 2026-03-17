import 'package:cine_scope/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> searchMovie({required String query, int page = 1});
  Future<Movie> getMovieById({required int id});
  Future<List<Movie>> getSimilarMovies({required int id, int page = 1});
}
