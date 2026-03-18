import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDatasource _remoteDatasource;
  final MovieLocalDatasource _localDatasource;

  MovieRepositoryImpl({
    required MovieRemoteDatasource remoteDatasource,
    required MovieLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<List<MovieSummary>> getPopularMovies({int page = 1}) async {
    final movies = await _remoteDatasource.getPopularMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> getTopRatedMovies({int page = 1}) async {
    final movies = await _remoteDatasource.getTopRatedMovies(page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> searchMovie({
    required String query,
    int page = 1,
  }) async {
    final movies = await _remoteDatasource.searchMovie(
      query: query,
      page: page,
    );
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<Movie> getMovieById({required int id}) async {
    final movie = await _remoteDatasource.getMovieById(id: id);
    return movie.toDomain();
  }

  @override
  Future<List<MovieSummary>> getSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    final movies = await _remoteDatasource.getSimilarMovies(id: id, page: page);
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<void> addFavorite(Movie movie) async {
    await _localDatasource.addFavorite(MovieLocalModel.fromDomain(movie));
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _localDatasource.removeFavorite(id);
  }

  @override
  bool isFavorite(int id) {
    return _localDatasource.isFavorite(id);
  }

  @override
  List<Movie> getFavorites() {
    return _localDatasource.getFavorites().map((x) => x.toDomain()).toList();
  }

  @override
  Future<void> addWatchLater(Movie movie) async {
    await _localDatasource.addWatchLater(MovieLocalModel.fromDomain(movie));
  }

  @override
  Future<void> removeWatchLater(int id) async {
    await _localDatasource.removeWatchLater(id);
  }

  @override
  bool isInWatchLater(int id) {
    return _localDatasource.isInWatchLater(id);
  }

  @override
  List<Movie> getWatchLater() {
    return _localDatasource.getWatchLater().map((x) => x.toDomain()).toList();
  }
}
