import 'package:cine_scope/features/movies/data/models/movie_model.dart';
import 'package:cine_scope/features/movies/data/models/movie_summary_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieSummaryModel>> fetchPopularMovies({int page = 1});
  Future<List<MovieSummaryModel>> fetchTopRatedMovies({int page = 1});
  Future<List<MovieSummaryModel>> fetchUpcomingMovies({int page = 1});
  Future<List<MovieSummaryModel>> searchMovie({
    required String query,
    int page = 1,
  });
  Future<MovieModel> fetchMovieById({required int id});
  Future<List<MovieSummaryModel>> fetchSimilarMovies({
    required int id,
    int page = 1,
  });
}
