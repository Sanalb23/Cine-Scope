import 'package:cine_scope/core/features/notifications/notification_service.dart';
import 'package:cine_scope/features/movies/presentation/utils/days_until_release_date.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MovieNotificationUtils {
  final NotificationService _notificationService;
  MovieNotificationUtils({required NotificationService notificationService})
    : _notificationService = notificationService;

  Future<void> scheduleMovieNotifications({
    required int movieId,
    required String movieTitle,
    required DateTime releaseDate,
  }) async {
    final releaseReminderId = _buildReleaseReminderId(movieId);

    await _scheduleReleaseReminder(releaseReminderId, movieTitle, releaseDate);

    final daysUntilRelease = daysUntilReleaseDate(releaseDate);
    if (daysUntilRelease == null) return;

    if (daysUntilRelease >= 3) {
      final countdownReminderId = _buildCountdownReminderId(movieId);
      await _scheduleCountdownReminder(
        countdownReminderId,
        movieTitle,
        releaseDate,
      );
    }
  }

  Future<void> cancelMovieNotifications({required int movieId}) async {
    final countdownReminderId = _buildCountdownReminderId(movieId);
    final releaseReminderId = _buildReleaseReminderId(movieId);

    await _notificationService.cancelNotification(countdownReminderId);
    await _notificationService.cancelNotification(releaseReminderId);
  }

  Future<void> _scheduleCountdownReminder(
    int uniqueId,
    String movieTitle,
    DateTime releaseDate,
  ) async {
    final reminderDate = releaseDate.subtract(const Duration(days: 3));

    await _notificationService.scheduleNotification(
      id: uniqueId,
      title: '3 days left!',
      body: '$movieTitle premieres very soon.',
      scheduledTime: reminderDate,
      channelId: 'movie_countdown_channel',
      channelName: 'Movie Countdown',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
  }

  Future<void> _scheduleReleaseReminder(
    int uniqueId,
    String movieTitle,
    DateTime releaseDate,
  ) async {
    await _notificationService.scheduleNotification(
      id: uniqueId,
      title: 'Now in theaters!',
      body: 'The premiere of $movieTitle is today.',
      scheduledTime: releaseDate,
      channelId: 'movie_release_channel',
      channelName: 'Movie Releases',
      importance: Importance.max,
      priority: Priority.high,
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
