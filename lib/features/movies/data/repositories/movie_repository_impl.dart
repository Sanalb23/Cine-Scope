import 'package:cine_scope/features/movies/data/datasource/movie_datasource.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_entity.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final movies = await datasource.getPopularMovies();
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieEntity>> getTopRatedMovies() async {
    final movies = await datasource.getTopRatedMovies();
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieEntity>> searchMovie({required String query}) async {
    final movies = await datasource.searchMovie(query: query);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<MovieEntity> getMovieById({required int id}) async {
    final movie = await datasource.getMovieById(id: id);
    return movie.toDomain();
  }

  @override
  Future<List<MovieEntity>> getSimilarMovies({required int id}) async {
    final movies = await datasource.getSimilarMovies(id: id);
    return movies.map((x) => x.toDomain()).toList();
  }
}
