import 'package:cine_scope/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getPopularMovies({int page = 1});
  Future<List<MovieEntity>> getTopRatedMovies({int page = 1});
  Future<List<MovieEntity>> searchMovie({required String query, int page = 1});
  Future<MovieEntity> getMovieById({required int id});
  Future<List<MovieEntity>> getSimilarMovies({required int id, int page = 1});
}
