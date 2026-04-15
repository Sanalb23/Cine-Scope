import 'dart:async';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider = AsyncNotifierProvider.autoDispose
    .family<SearchMoviesNotifier, List<MovieSummary>, String>(
      SearchMoviesNotifier.new,
    );

class SearchMoviesNotifier extends BasePaginatedMoviesNotifier {
  final String query;
  SearchMoviesNotifier(this.query, {super.preloadPostersFn});

  @override
  Future<List<MovieSummary>> build() {
    if (query.isEmpty) {
      return Future.value([]);
    }
    return super.build();
  }

  @override
  Future<List<MovieSummary>> fetchMoviesFromRepository(int page) {
    return ref
        .read(movieRepositoryProvider)
        .searchMovie(query: query, page: page);
  }
}
