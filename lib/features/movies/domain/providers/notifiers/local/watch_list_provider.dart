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
    return ref.watch(movieRepositoryProvider).getWatchList();
  }

  Future<void> toggleInWatchList(Movie movie) async {
    if (ref.read(isInWatchListProvider(movie.id))) {
      await ref.read(movieRepositoryProvider).removeFromWatchList(movie.id);
    } else {
      await ref.read(movieRepositoryProvider).addToWatchList(movie);
    }

    state = ref.read(movieRepositoryProvider).getWatchList();
  }
}
