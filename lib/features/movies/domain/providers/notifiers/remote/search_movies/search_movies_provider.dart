import 'dart:async';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider = NotifierProvider.autoDispose
    .family<SearchMoviesNotifier, PaginatedState<MovieSummary>, String>(
      SearchMoviesNotifier.new,
    );

class SearchMoviesNotifier extends BasePaginatedMoviesNotifier {
  SearchMoviesNotifier(this.query);

  final String query;

  @override
  PaginatedState<MovieSummary> build() {
    if (query.isEmpty) return PaginatedState();

    final link = ref.keepAlive();

    final timer = Timer(const Duration(minutes: 3), () => link.close());

    ref.onDispose(() => timer.cancel());

    return super.build();
  }

  @override
  Future<List<MovieSummary>> fetchItems(int page) {
    return ref
        .read(movieRepositoryProvider)
        .searchMovie(query: query, page: page);
  }
}
