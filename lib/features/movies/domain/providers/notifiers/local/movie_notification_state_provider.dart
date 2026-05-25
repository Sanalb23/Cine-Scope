import 'package:cine_scope/features/movies/domain/providers/movie_notification_utils_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieNotificationStateProvider = AsyncNotifierProvider.autoDispose
    .family<MovieNotificationStateNotifier, bool, int>(
      MovieNotificationStateNotifier.new,
    );

class MovieNotificationStateNotifier extends AsyncNotifier<bool> {
  int movieId;
  MovieNotificationStateNotifier(this.movieId);

  @override
  Future<bool> build() async {
    final utils = ref.watch(movieNotificationUtilsProvider);
    return await utils.isMovieNotificationScheduled(movieId);
  }

  Future<void> toggleState(String movieTitle, DateTime releaseDate) async {
    if (state.isLoading) return;

    state = const AsyncLoading();

    final keepAliveLink = ref.keepAlive();

    try {
      final utils = ref.read(movieNotificationUtilsProvider);

      final isCurrentlyScheduled = state.value ?? false;

      if (isCurrentlyScheduled) {
        await utils.cancelMovieNotifications(movieId: movieId);
        state = const AsyncData(false);
      } else {
        await utils.scheduleMovieNotifications(
          movieId: movieId,
          movieTitle: movieTitle,
          releaseDate: releaseDate,
        );
        state = const AsyncData(true);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      keepAliveLink.close();
    }
  }
}
