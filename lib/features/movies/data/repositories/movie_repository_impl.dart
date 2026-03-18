import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource remoteDatasource;
  final MovieLocalDatasource localDatasource;

  MovieRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<List<MovieSummary>> getPopularMovies({int page = 1}) async {
    final movies = await remoteDatasource.getPopularMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> getTopRatedMovies({int page = 1}) async {
    final movies = await remoteDatasource.getTopRatedMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    final movies = await remoteDatasource.searchMovie(query: query, page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<Movie> getMovieById({required int id}) async {
    final movie = await remoteDatasource.getMovieById(id: id);
    return movie.toDomain();
  }

  @override
  Future<List<MovieSummary>> getSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    final movies = await remoteDatasource.getSimilarMovies(id: id, page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<void> addFavorite(Movie movie) async {
    await localDatasource.addFavorite(MovieLocalModel.fromDomain(movie));
  }

  @override
  Future<void> removeFavorite(int id) async {
    await localDatasource.removeFavorite(id);
  }

  @override
  bool isFavorite(int id) {
    return localDatasource.isFavorite(id);
  }

  @override
  List<Movie> getFavorites() {
    return localDatasource.getFavorites().map((x) => x.toDomain()).toList();
  }

  @override
  Future<void> addWatchLater(Movie movie) async {
    await localDatasource.addWatchLater(MovieLocalModel.fromDomain(movie));
  }

  @override
  Future<void> removeWatchLater(int id) async {
    await localDatasource.removeWatchLater(id);
  }

  @override
  bool isInWatchLater(int id) {
    return localDatasource.isInWatchLater(id);
  }

  @override
  List<Movie> getWatchLater() {
    return localDatasource.getWatchLater().map((x) => x.toDomain()).toList();
  }
}
