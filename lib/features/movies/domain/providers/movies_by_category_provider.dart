import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/popular_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/top_rated_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginatedListState = ({
  AsyncValue<List<MovieSummary>> movies,
  Future<void> Function() fetchMore,
});

final moviesByCategoryProvider =
    Provider.family<PaginatedListState, MovieListCategory>((ref, category) {
      switch (category) {
        case MovieListCategory.popular:
          return (
            movies: ref.watch(popularMoviesProvider),
            fetchMore: ref.read(popularMoviesProvider.notifier).fetchMore,
          );
        case MovieListCategory.topRated:
          return (
            movies: ref.watch(topRatedMoviesProvider),
            fetchMore: ref.read(topRatedMoviesProvider.notifier).fetchMore,
          );
      }
    });
