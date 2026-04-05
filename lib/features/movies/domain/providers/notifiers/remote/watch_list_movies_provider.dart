import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListMoviesProvider =
    AsyncNotifierProvider<WatchListMoviesNotifier, List<MovieSummary>>(() {
      return WatchListMoviesNotifier();
    });

class WatchListMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getWatchListMovies();
  }

  Future<void> getWatchListMovies() async {
    state = AsyncData(
      await ref.watch(movieRepositoryProvider).getWatchListMovies(),
    );
  }
}
