import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/popular_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/top_rated_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/upcoming_movies_provider.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginatedListState = ({
  PaginatedState<MovieSummary> state,
  VoidCallback fetchCallback,
  VoidCallback retryCallback,
});

final moviesByCategoryProvider =
    Provider.family<PaginatedListState, MovieListCategory>((ref, category) {
      switch (category) {
        case MovieListCategory.popular:
          return (
            state: ref.watch(popularMoviesProvider),
            fetchCallback: ref.read(popularMoviesProvider.notifier).fetchMore,
            retryCallback: () =>
                ref.read(popularMoviesProvider.notifier).retry(),
          );
        case MovieListCategory.topRated:
          return (
            state: ref.watch(topRatedMoviesProvider),
            fetchCallback: ref.read(topRatedMoviesProvider.notifier).fetchMore,
            retryCallback: () =>
                ref.read(topRatedMoviesProvider.notifier).retry(),
          );
        case MovieListCategory.upcoming:
          return (
            state: ref.watch(upcomingMoviesProvider),
            fetchCallback: ref.read(upcomingMoviesProvider.notifier).fetchMore,
            retryCallback: () =>
                ref.read(upcomingMoviesProvider.notifier).retry(),
          );
      }
    });
