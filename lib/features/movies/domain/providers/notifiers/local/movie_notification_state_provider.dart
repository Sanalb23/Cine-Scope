import 'package:cine_scope/core/providers/permission_service_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_notification_utils_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_in_watch_list_provider.dart';
import 'package:easy_localization/easy_localization.dart';
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

    final isCurrentlyScheduled = state.value ?? false;

    state = const AsyncLoading();

    final keepAliveLink = ref.keepAlive();

    try {
      final utils = ref.read(movieNotificationUtilsProvider);

      if (isCurrentlyScheduled) {
        await utils.cancelMovieNotifications(movieId: movieId);
        state = const AsyncData(false);
      } else {
        final notificationsEnabled = await ref
            .read(permissionServiceProvider)
            .checkAndRequestNotificationPermission();

        if (!notificationsEnabled) {
          state = AsyncError(
            'notifications_must_be_enabled'.tr(),
            StackTrace.current,
          );
          return;
        }

        final isBatteryOptimizationEnabled = await ref
            .read(permissionServiceProvider)
            .checkAndRequestBatteryOptimization();

        if (!isBatteryOptimizationEnabled) {
          state = AsyncError(
            'background_execution_must_be_enabled'.tr(),
            StackTrace.current,
          );
          return;
        }

        await utils.scheduleMovieNotifications(
          movieId: movieId,
          movieTitle: movieTitle,
          releaseDate: releaseDate,
        );

        final watchListState = ref.read(isInWatchListProvider(movieId));

        if (!watchListState) {
          ref.read(isInWatchListProvider(movieId).notifier).toggleWatchList();
        }

        state = const AsyncData(true);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      keepAliveLink.close();
    }
  }
}
