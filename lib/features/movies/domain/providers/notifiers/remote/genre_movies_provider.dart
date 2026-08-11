import 'dart:async';

import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genreMoviesProvider = NotifierProvider.autoDispose
    .family<GenreMoviesNotifier, PaginatedState<MovieSummary>, int>(
      GenreMoviesNotifier.new,
    );

class GenreMoviesNotifier extends BasePaginatedMoviesNotifier {
  GenreMoviesNotifier(this.genreId);

  final int genreId;

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
        .fetchPopularMovies(page: page, genreIds: [genreId]);
  }
}
