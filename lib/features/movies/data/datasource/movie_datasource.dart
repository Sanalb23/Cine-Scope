import 'package:cine_scope/features/movies/data/models/movie_model.dart';

abstract class MovieDatasource {
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<List<MovieModel>> searchMovie({required String query});
  Future<MovieModel> getMovieById({required int id});
  Future<List<MovieModel>> getSimilarMovies({required int id});
}
