import 'dart:async';

import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = NotifierProvider.autoDispose
    .family<SimilarMoviesNotifier, PaginatedState<MovieSummary>, int>(
      SimilarMoviesNotifier.new,
    );

class SimilarMoviesNotifier extends BasePaginatedMoviesNotifier {
  final int movieId;

  SimilarMoviesNotifier(this.movieId);

  @override
  PaginatedState<MovieSummary> build() {
    final link = ref.keepAlive();

    final timer = Timer(const Duration(minutes: 3), () {
      link.close();
    });

    ref.onDispose(() {
      timer.cancel();
    });

    return super.build();
  }

  @override
  Future<List<MovieSummary>> fetchItems(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .getSimilarMovies(page: page, id: movieId);
  }
}
