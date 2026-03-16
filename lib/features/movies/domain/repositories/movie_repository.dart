import 'package:cine_scope/features/movies/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getTopRatedMovies();
  Future<List<MovieEntity>> searchMovie({required String query});
  Future<MovieEntity> getMovieById({required int id});
  Future<List<MovieEntity>> getSimilarMovies({required int id});
}
