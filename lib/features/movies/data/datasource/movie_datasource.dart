import 'package:cine_scope/features/movies/data/models/movie_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getTopRatedMovies({int page = 1});
  Future<List<MovieModel>> searchMovie({required String query, int page = 1});
  Future<MovieModel> getMovieById({required int id});
  Future<List<MovieModel>> getSimilarMovies({required int id, int page = 1});
}
