import 'dart:async';

import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = AsyncNotifierProvider.autoDispose
    .family<SimilarMoviesNotifier, List<MovieSummary>, int>(
      SimilarMoviesNotifier.new,
    );

class SimilarMoviesNotifier extends BasePaginatedMoviesNotifier {
  final int movieId;

  SimilarMoviesNotifier(this.movieId);

  @override
  Future<List<MovieSummary>> fetchMoviesFromRepository(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .getSimilarMovies(page: page, id: movieId);
  }
}
