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
  Future<List<MovieSummary>> fetchPopularMovies({
    int page = 1,
    List<int>? genreIds,
  }) async {
    final movies = await _remoteDatasource.fetchPopularMovies(
      page: page,
      genreIds: genreIds,
    );
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> fetchTopRatedMovies({
    int page = 1,
    List<int>? genreIds,
  }) async {
    final movies = await _remoteDatasource.fetchTopRatedMovies(
      page: page,
      genreIds: genreIds,
    );
    return movies.map((x) => x.toDomain()).toList();
  }

  @override
  Future<List<MovieSummary>> fetchUpcomingMovies({
    int page = 1,
    List<int>? genreIds,
  }) async {
    final movies = await _remoteDatasource.fetchUpcomingMovies(
      page: page,
      genreIds: genreIds,
    );
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
  Future<Movie> fetchMovieById({required int id}) async {
    return await _remoteDatasource
        .fetchMovieById(id: id)
        .then((x) => x.toDomain());
  }

  @override
  Future<List<MovieSummary>> fetchSimilarMovies({
    required int id,
    int page = 1,
  }) async {
    final movies = await _remoteDatasource.fetchSimilarMovies(
      id: id,
      page: page,
    );
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
  Future<List<MovieSummary>> fetchFavoriteMovies({
    int page = 1,
    List<int>? genreIds,
  }) async {
    final ids = _localDatasource.getFavorites();

    final paginatedIds = _paginatedList(page, ids);

    final futures = paginatedIds.map((id) async {
      try {
        final movie = await _remoteDatasource.fetchMovieById(id: id);
        return movie.toMovieSummaryModel().toDomain();
      } catch (_) {
        // Return null if fetching the movie fails
        return null;
      }
    });

    final results = await Future.wait(futures);

    // Filter out the nulls
    List<MovieSummary> filteredResults = results
        .whereType<MovieSummary>()
        .toList();

    // Filter by genre if genreIds are provided
    if (genreIds != null && genreIds.isNotEmpty) {
      filteredResults = filteredResults
          .where((x) => x.genreIds.any((id) => genreIds.contains(id)))
          .toList();
    }

    return filteredResults;
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
  Future<List<MovieSummary>> fetchWatchListMovies({
    int page = 1,
    List<int>? genreIds,
  }) async {
    final ids = _localDatasource.getWatchList();

    final paginatedIds = _paginatedList(page, ids);

    final futures = paginatedIds.map((id) async {
      try {
        final movie = await _remoteDatasource.fetchMovieById(id: id);
        return movie.toMovieSummaryModel().toDomain();
      } catch (_) {
        // Return null if fetching the movie fails
        return null;
      }
    });

    final results = await Future.wait(futures);

    // Filter out the nulls
    List<MovieSummary> filteredResults = results
        .whereType<MovieSummary>()
        .toList();

    // Filter by genre if genreIds are provided
    if (genreIds != null && genreIds.isNotEmpty) {
      filteredResults = filteredResults
          .where((x) => x.genreIds.any((id) => genreIds.contains(id)))
          .toList();
    }

    return filteredResults;
  }

  @override
  bool isInWatchList(int id) {
    return _localDatasource.getWatchList().contains(id);
  }

  List<int> _paginatedList(int page, List<int> list) {
    const pageLimit = 20;

    final pageStart = (page - 1) * pageLimit;

    return list.skip(pageStart).take(pageLimit).toList();
  }
}
