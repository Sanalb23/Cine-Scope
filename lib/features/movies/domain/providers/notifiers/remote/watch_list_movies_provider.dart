import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListMoviesProvider =
    AsyncNotifierProvider.autoDispose<
      WatchListMoviesNotifier,
      List<MovieSummary>
    >(() {
      return WatchListMoviesNotifier();
    });

class WatchListMoviesNotifier extends BasePaginatedMoviesNotifier {
  @override
  Future<List<MovieSummary>> fetchMoviesFromRepository(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .getWatchListMovies(page: page);
  }
}
