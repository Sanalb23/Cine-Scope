import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListProvider =
    NotifierProvider<WatchListNotifier, List<MovieSummary>>(() {
      return WatchListNotifier();
    });

final isInWatchListProvider = Provider.family<bool, int>((ref, id) {
  final watchList = ref.watch(watchListProvider);
  return watchList.any((m) => m.id == id);
});

class WatchListNotifier extends Notifier<List<MovieSummary>> {
  @override
  List<MovieSummary> build() {
    return ref.watch(movieRepositoryProvider).getWatchLater();
  }

  Future<void> addWatchLater(Movie movie) async {
    await ref.read(movieRepositoryProvider).addWatchLater(movie);

    state = ref.read(movieRepositoryProvider).getWatchLater();
  }

  Future<void> removeWatchLater(MovieSummary movie) async {
    await ref.read(movieRepositoryProvider).removeWatchLater(movie.id);

    state = ref.read(movieRepositoryProvider).getWatchLater();
  }
}
