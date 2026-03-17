import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';

abstract class MovieDatasource {
  Future<List<MovieSummaryModel>> getPopularMovies({int page = 1});
  Future<List<MovieSummaryModel>> getTopRatedMovies({int page = 1});
  Future<List<MovieSummaryModel>> searchMovie({
    required String query,
    int page = 1,
  });
  Future<MovieModel> getMovieById({required int id});
  Future<List<MovieSummaryModel>> getSimilarMovies({
    required int id,
    int page = 1,
  });
}
