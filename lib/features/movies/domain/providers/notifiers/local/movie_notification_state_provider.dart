import 'package:cine_scope/core/providers/permission_service_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_notification_utils_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_in_watch_list_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieNotificationStateProvider = AsyncNotifierProvider.autoDispose
    .family<MovieNotificationStateNotifier, MovieNotificationState, int>(
      MovieNotificationStateNotifier.new,
    );

class MovieNotificationStateNotifier
    extends AsyncNotifier<MovieNotificationState> {
  int movieId;
  MovieNotificationStateNotifier(this.movieId);

  @override
  Future<MovieNotificationState> build() async {
    final utils = await ref.watch(movieNotificationUtilsProvider.future);
    final isScheduled = await utils.isMovieNotificationScheduled(movieId);
    return MovieNotificationState.success(isScheduled: isScheduled);
  }

  Future<void> toggleState(
    String movieTitle,
    DateTime releaseDate,
    String? posterPath,
    String? backdropPath,
  ) async {
    if (state.isLoading) return;

    final isCurrentlyScheduled = state.value?.isScheduled ?? false;

    state = const AsyncLoading();

    final keepAliveLink = ref.keepAlive();

    try {
      final utils = await ref.read(movieNotificationUtilsProvider.future);

      if (isCurrentlyScheduled) {
        await utils.cancelMovieNotifications(movieId: movieId);
        state = AsyncData(MovieNotificationState.success(isScheduled: false));
      } else {
        final notificationsEnabled = await ref
            .read(permissionServiceProvider)
            .checkAndRequestNotificationPermission();

        if (!notificationsEnabled) {
          state = AsyncData(
            MovieNotificationState.permissionError(
              isScheduled: false,
              errorMessage: 'notifications_must_be_enabled'.tr(),
            ),
          );
          return;
        }

        final isBatteryOptimizationEnabled = await ref
            .read(permissionServiceProvider)
            .checkAndRequestBatteryOptimization();

        if (!isBatteryOptimizationEnabled) {
          state = AsyncData(
            MovieNotificationState.permissionError(
              isScheduled: false,
              errorMessage: 'background_execution_must_be_enabled'.tr(),
            ),
          );
          return;
        }

        await utils.scheduleMovieNotifications(
          movieId: movieId,
          movieTitle: movieTitle,
          releaseDate: releaseDate,
          posterPath: posterPath,
          backdropPath: backdropPath,
        );

        final watchListState = ref.read(isInWatchListProvider(movieId));

        if (!watchListState) {
          ref.read(isInWatchListProvider(movieId).notifier).toggleWatchList();
        }

        state = AsyncData(MovieNotificationState.success(isScheduled: true));
      }
    } catch (e) {
      state = AsyncData(
        MovieNotificationState.codeError(
          isScheduled: isCurrentlyScheduled,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      keepAliveLink.close();
    }
  }
}

enum MovieNotificationStatus { success, error }

enum MovieNotificationErrorType { code, permission }

class MovieNotificationState {
  final MovieNotificationStatus status;
  final MovieNotificationErrorType? errorType;
  final bool isScheduled;
  final String? errorMessage;

  const MovieNotificationState({
    required this.status,
    this.errorType,
    required this.isScheduled,
    this.errorMessage,
  });

  const MovieNotificationState.success({required this.isScheduled})
    : status = MovieNotificationStatus.success,
      errorType = null,
      errorMessage = null;

  const MovieNotificationState.permissionError({
    required this.isScheduled,
    required this.errorMessage,
  }) : status = MovieNotificationStatus.error,
       errorType = MovieNotificationErrorType.permission;

  const MovieNotificationState.codeError({
    required this.isScheduled,
    required this.errorMessage,
  }) : status = MovieNotificationStatus.error,
       errorType = MovieNotificationErrorType.code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieNotificationState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          errorType == other.errorType &&
          isScheduled == other.isScheduled &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(status, errorType, isScheduled, errorMessage);
}
