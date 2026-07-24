import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/popular_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/top_rated_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/upcoming_movies_provider.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginatedListState = ({
  MovieListCategory category,
  PaginatedState<MovieSummary> state,
  VoidCallback fetchCallback,
  VoidCallback retryCallback,
});

final moviesByCategoryProvider =
    NotifierProvider<MoviesByCategoryNotifier, PaginatedListState>(
      MoviesByCategoryNotifier.new,
    );

class MoviesByCategoryNotifier extends Notifier<PaginatedListState> {
  MovieListCategory _category = MovieListCategory.popular;

  @override
  PaginatedListState build() {
    switch (_category) {
      case MovieListCategory.popular:
        return (
          category: _category,
          state: ref.watch(popularMoviesProvider),
          fetchCallback: ref.read(popularMoviesProvider.notifier).fetchMore,
          retryCallback: () => ref.read(popularMoviesProvider.notifier).retry(),
        );
      case MovieListCategory.topRated:
        return (
          category: _category,
          state: ref.watch(topRatedMoviesProvider),
          fetchCallback: ref.read(topRatedMoviesProvider.notifier).fetchMore,
          retryCallback: () => ref.read(topRatedMoviesProvider.notifier).retry(),
        );
      case MovieListCategory.upcoming:
        return (
          category: _category,
          state: ref.watch(upcomingMoviesProvider),
          fetchCallback: ref.read(upcomingMoviesProvider.notifier).fetchMore,
          retryCallback: () => ref.read(upcomingMoviesProvider.notifier).retry(),
        );
    }
  }

  void switchCategory(MovieListCategory category) {
    if (_category != category) {
      _category = category;
      ref.invalidateSelf();
    }
  }
}

