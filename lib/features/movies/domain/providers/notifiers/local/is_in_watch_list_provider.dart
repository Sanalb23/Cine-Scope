import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/watch_list_movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isInWatchListProvider = NotifierProvider.autoDispose
    .family<IsInWatchListNotifier, bool, int>(IsInWatchListNotifier.new);

class IsInWatchListNotifier extends Notifier<bool> {
  IsInWatchListNotifier(this.id);

  final int id;

  @override
  bool build() {
    return ref.watch(movieRepositoryProvider).isInWatchList(id);
  }

  void toggleWatchList() {
    final isInWatchList = ref.read(movieRepositoryProvider).isInWatchList(id);

    if (isInWatchList) {
      ref.read(movieRepositoryProvider).removeFromWatchList(id);
    } else {
      ref.read(movieRepositoryProvider).addToWatchList(id);
    }

    state = ref.read(movieRepositoryProvider).isInWatchList(id);

    ref.invalidate(watchListMoviesProvider);
  }
}
