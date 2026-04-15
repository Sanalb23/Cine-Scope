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
    _currentPage = 1;
    _isFetchingMore = false;

    final movies = await fetchMoviesFromRepository(_currentPage);
    final preloader = preloadPostersFn ?? preloadPosters;
    await preloader(movies);
    return movies;
  }

  Future<void> fetchMore() async {
    if (_isFetchingMore || !state.hasValue) return;

    _isFetchingMore = true;

    _currentPage++;

    try {
      final newMovies = await fetchMoviesFromRepository(_currentPage);

      final currentMovies = state.value!;

      final preloader = preloadPostersFn ?? preloadPosters;
      await preloader(newMovies);

      state = AsyncData([...currentMovies, ...newMovies]);
    } catch (e) {
      // TODO: handle error
    } finally {
      _isFetchingMore = false;
    }
  }
}
