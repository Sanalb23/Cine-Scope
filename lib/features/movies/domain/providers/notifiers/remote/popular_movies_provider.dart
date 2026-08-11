import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_genre_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularMoviesProvider =
    NotifierProvider<PopularMoviesNotifier, PaginatedState<MovieSummary>>(
      PopularMoviesNotifier.new,
    );

class PopularMoviesNotifier extends BasePaginatedGenreMoviesNotifier {
  @override
  Future<List<MovieSummary>> fetchItems(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .fetchPopularMovies(page: page, genreIds: genreIds);
  }
}
