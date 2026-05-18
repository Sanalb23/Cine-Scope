import 'package:cine_scope/features/notifications/notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MovieNotificationUtils {
  final NotificationService _notificationService = NotificationService();

  Future<void> scheduleCountdownReminder(
    int movieId,
    String movieTitle,
    DateTime releaseDate,
  ) async {
    final reminderDate = releaseDate.subtract(const Duration(days: 3));

    await _notificationService.scheduleNotification(
      id: movieId,
      title: '3 days left!',
      body: '$movieTitle premieres very soon.',
      scheduledTime: reminderDate,
      channelId: 'movie_countdown_channel',
      channelName: 'Movie Countdown',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
  }

  Future<void> scheduleReleaseReminder(
    int movieId,
    String movieTitle,
    DateTime releaseDate,
  ) async {
    await _notificationService.scheduleNotification(
      id: movieId + 10000,
      title: 'Now in theaters!',
      body: 'The premiere of $movieTitle is today.',
      scheduledTime: releaseDate,
      channelId: 'movie_release_channel',
      channelName: 'Movie Releases',
      importance: Importance.max,
      priority: Priority.high,
    );
  }
}
