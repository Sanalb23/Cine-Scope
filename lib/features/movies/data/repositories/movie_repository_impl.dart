import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/data/repositories/movie_repository.dart';

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
    return await _remoteDatasource
        .getMovieById(id: id)
        .then((x) => x.toDomain());
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
  Future<void> addFavorite(int id) async {
    await _localDatasource.addFavorite(id);
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _localDatasource.removeFavorite(id);
  }

  @override
  Future<List<MovieSummary>> getFavoriteMovies() async {
    final ids = _localDatasource.getFavorites();

    final futures = ids.map((id) async {
      try {
        final movie = await _remoteDatasource.getMovieById(id: id);
        return movie.toMovieSummaryModel().toDomain();
      } catch (_) {
        // Return null if fetching the movie fails
        return null;
      }
    });

    final results = await Future.wait(futures);
    // Filter out the nulls
    return results.whereType<MovieSummary>().toList();
  }

  @override
  bool isFavorite(int id) {
    return _localDatasource.getFavorites().contains(id);
  }

  @override
  Future<void> addToWatchList(int id) async {
    await _localDatasource.addToWatchList(id);
  }

  @override
  Future<void> removeFromWatchList(int id) async {
    await _localDatasource.removeFromWatchList(id);
  }

  @override
  Future<List<MovieSummary>> getWatchListMovies() async {
    final ids = _localDatasource.getWatchList();

    final futures = ids.map((id) async {
      try {
        final movie = await _remoteDatasource.getMovieById(id: id);
        return movie.toMovieSummaryModel().toDomain();
      } catch (_) {
        // Return null if fetching the movie fails
        return null;
      }
    });

    final results = await Future.wait(futures);
    // Filter out the nulls
    return results.whereType<MovieSummary>().toList();
  }

  @override
  bool isInWatchList(int id) {
    return _localDatasource.getWatchList().contains(id);
  }
}
