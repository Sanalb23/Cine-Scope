import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final upcomingMoviesProvider =
    AsyncNotifierProvider<UpcomingMoviesNotifier, List<MovieSummary>>(
      UpcomingMoviesNotifier.new,
    );

class UpcomingMoviesNotifier extends BasePaginatedMoviesNotifier {
  @override
  Future<List<MovieSummary>> fetchMoviesFromRepository(int page) {
    return ref.read(movieRepositoryProvider).getUpcomingMovies(page: page);
  }
}
