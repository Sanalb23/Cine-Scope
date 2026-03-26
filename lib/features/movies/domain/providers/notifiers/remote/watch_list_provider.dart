import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListProvider =
    AsyncNotifierProvider<WatchListNotifier, List<MovieSummary>>(() {
      return WatchListNotifier();
    });

final isInWatchListProvider = Provider.family<bool, int>((ref, id) {
  final watchList = ref.watch(watchListProvider);
  return watchList.value?.any((m) => m.id == id) ?? false;
});

class WatchListNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getWatchList();
  }

  Future<void> toggleInWatchList(Movie movie) async {
    final isInWatchList = ref.read(isInWatchListProvider(movie.id));

    if (isInWatchList) {
      await ref.read(movieRepositoryProvider).removeFromWatchList(movie.id);
    } else {
      await ref.read(movieRepositoryProvider).addToWatchList(movie.id);
    }

    state = AsyncData(await ref.read(movieRepositoryProvider).getWatchList());
  }
}
