import 'package:cine_scope/features/notifications/services/notification_service.dart';
import 'package:cine_scope/features/movies/presentation/utils/days_until_release_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MovieNotificationUtils {
  final NotificationService _notificationService;
  MovieNotificationUtils({required NotificationService notificationService})
    : _notificationService = notificationService;

  Future<void> scheduleMovieNotifications({
    required int movieId,
    required String movieTitle,
    required DateTime releaseDate,
    required String? posterPath,
    required String? backdropPath,
  }) async {
    final releaseReminderId = _buildReleaseReminderId(movieId);

    await _scheduleReleaseReminder(
      releaseReminderId,

      movieTitle,

      releaseDate,
      posterPath,
      backdropPath,

      movieId,
    );

    final daysUntilRelease = daysUntilReleaseDate(releaseDate);
    if (daysUntilRelease == null) return;

    if (daysUntilRelease >= 3) {
      final countdownReminderId = _buildCountdownReminderId(movieId);
      await _scheduleCountdownReminder(
        countdownReminderId,
        movieTitle,
        releaseDate,
        posterPath,
        backdropPath,
        movieId,
      );
    }
  }

  Future<void> cancelMovieNotifications({required int movieId}) async {
    final countdownReminderId = _buildCountdownReminderId(movieId);
    final releaseReminderId = _buildReleaseReminderId(movieId);

    await _notificationService.cancelNotification(countdownReminderId);
    await _notificationService.cancelNotification(releaseReminderId);
  }

  Future<bool> isMovieNotificationScheduled(int movieId) async {
    final releaseReminderId = _buildReleaseReminderId(movieId);
    final countdownReminderId = _buildCountdownReminderId(movieId);

    final isReleaseReminderScheduled = await _notificationService
        .isNotificationScheduled(releaseReminderId);

    final isCountdownReminderScheduled = await _notificationService
        .isNotificationScheduled(countdownReminderId);

    return isReleaseReminderScheduled || isCountdownReminderScheduled;
  }

  Future<void> _scheduleCountdownReminder(
    int uniqueId,
    String movieTitle,
    DateTime releaseDate,
    String? posterPath,
    String? backdropPath,
    int movieId,
  ) async {
    final reminderDate = releaseDate.subtract(const Duration(days: 3));

    await _notificationService.scheduleNotification(
      id: uniqueId,
      title: 'days_left'.tr(namedArgs: {'days': '3'}),
      body: 'premieres_very_soon'.tr(namedArgs: {'movie_title': movieTitle}),
      scheduledTime: reminderDate,
      channelId: 'movie_countdown_channel',
      channelName: 'movie_countdown'.tr(),
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      posterPath: posterPath,
      backdropPath: backdropPath,
      payload: '/movie_details_screen/$movieId',
    );
  }

  Future<void> _scheduleReleaseReminder(
    int uniqueId,
    String movieTitle,
    DateTime releaseDate,
    String? posterPath,
    String? backdropPath,
    int movieId,
  ) async {
    await _notificationService.scheduleNotification(
      id: uniqueId,
      title: 'now_in_theaters'.tr(),
      body: 'premiere_is_today'.tr(namedArgs: {'movie_title': movieTitle}),
      scheduledTime: releaseDate,
      channelId: 'movie_release_channel',
      channelName: 'movie_releases'.tr(),
      importance: Importance.max,
      priority: Priority.high,
      posterPath: posterPath,
      backdropPath: backdropPath,
      payload: '/movie_details_screen/$movieId',
    );
  }

  int _buildReleaseReminderId(int movieId) {
    final uniqueStringId = "${movieId}_release_reminder";
    return uniqueStringId.hashCode;
  }

  int _buildCountdownReminderId(int movieId) {
    final uniqueStringId = "${movieId}_3_days_countdown_reminder";
    return uniqueStringId.hashCode;
  }
}
