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
  Future<List<MovieSummary>> build() async {
    if (query.isEmpty) return Future.value([]);

    bool isCancelled = false;

    ref.onDispose(() => isCancelled = true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (isCancelled) return [];

    final link = ref.keepAlive();

    final timer = Timer(const Duration(minutes: 3), () {
      link.close();
    });

    ref.onDispose(() => timer.cancel());

    return super.build();
  }

  @override
  Future<List<MovieSummary>> fetchMoviesFromRepository(int page) {
    return ref
        .read(movieRepositoryProvider)
        .searchMovie(query: query, page: page);
  }
}
