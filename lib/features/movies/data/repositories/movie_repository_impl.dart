import 'package:cine_scope/features/movies/data/datasource/movie_datasource.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_entity.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final movies = await datasource.getPopularMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final movies = await datasource.getTopRatedMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<Movie>> searchMovie({required String query, int page = 1}) async {
    final movies = await datasource.searchMovie(query: query, page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<Movie> getMovieById({required int id}) async {
    final movie = await datasource.getMovieById(id: id);
    return movie.toDomain();
  }

  @override
  Future<List<Movie>> getSimilarMovies({required int id, int page = 1}) async {
    final movies = await datasource.getSimilarMovies(id: id, page: page);
    return movies.map((x) => x.toDomain()).toList();
  }
}
