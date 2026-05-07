import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    NotifierProvider.autoDispose<
      FavoriteMoviesNotifier,
      PaginatedState<MovieSummary>
    >(FavoriteMoviesNotifier.new);

class FavoriteMoviesNotifier extends BasePaginatedMoviesNotifier {
  @override
  Future<List<MovieSummary>> fetchItems(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .getFavoriteMovies(page: page);
  }
}
