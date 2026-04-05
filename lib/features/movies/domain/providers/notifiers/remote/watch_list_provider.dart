import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final watchListProvider =
    AsyncNotifierProvider<WatchListNotifier, List<MovieSummary>>(() {
      return WatchListNotifier();
    });

final isInWatchListProvider = Provider.family.autoDispose<bool, int>((ref, id) {
  return ref.watch(movieRepositoryProvider).isInWatchList(id);
});

class WatchListNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getWatchListMovies();
  }

  Future<void> toggleInWatchList(int id) async {
    final isInWatchList = ref.read(movieRepositoryProvider).isInWatchList(id);

    if (isInWatchList) {
      await ref.read(movieRepositoryProvider).removeFromWatchList(id);
    } else {
      await ref.read(movieRepositoryProvider).addToWatchList(id);
    }

    state = AsyncData(
      await ref.read(movieRepositoryProvider).getWatchListMovies(),
    );
  }
}
