import 'package:cine_scope/core/providers/notification_service_provider.dart';
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
        final notificationsEnabled = await ref
            .read(notificationServiceProvider)
            .areNotificationsEnabled();

        if (notificationsEnabled == null || !notificationsEnabled) {
          final isGranted = await ref
              .read(notificationServiceProvider)
              .requestPermissions();

          if (isGranted == null || !isGranted) {
            state = AsyncError(
              'Notifications must be enabled to schedule movie reminders.',
              StackTrace.current,
            );
            return;
          }
        }

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
