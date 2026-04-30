import 'package:cine_scope/features/movies/data/utils/preload_posters.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BasePaginatedMoviesNotifier
    extends AsyncNotifier<List<MovieSummary>> {
  BasePaginatedMoviesNotifier({this.preloadPostersFn});

  final Future<List<MovieSummary>> Function(List<MovieSummary>)?
  preloadPostersFn;

  int _currentPage = 1;
  bool _isFetchingMore = false;

  Future<List<MovieSummary>> fetchMoviesFromRepository(int page);

  @override
  Future<List<MovieSummary>> build() async {
    final movies = await fetchMoviesFromRepository(_currentPage);
    final preloader = preloadPostersFn ?? preloadPosters;
    await preloader(movies);

    _currentPage++;

    return movies;
  }

  Future<List<MovieSummary>> fetchMore() async {
    if (_isFetchingMore || !state.hasValue) return [];

    _isFetchingMore = true;

    try {
      final newMovies = await fetchMoviesFromRepository(_currentPage);

      final currentMovies = state.value!;

      final preloader = preloadPostersFn ?? preloadPosters;
      await preloader(newMovies);

      state = AsyncData([...currentMovies, ...newMovies]);

      _currentPage++;

      return newMovies;
    } catch (e) {
      rethrow;
    } finally {
      _isFetchingMore = false;
    }
  }
}
