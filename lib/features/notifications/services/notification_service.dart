import 'package:cine_scope/features/notifications/models/scheduled_notification_model.dart';
import 'package:cine_scope/features/notifications/services/notification_local_datasource.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final NotificationLocalDataSource _dataSource;

  NotificationService(this._dataSource);

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(settings: initializationSettings);
    await _restoreScheduledNotifications();
  }

  Future<void> _restoreScheduledNotifications() async {
    final savedNotifications = _dataSource.getScheduledNotifications();
    final now = DateTime.now();

    for (final notification in savedNotifications) {
      if (notification.scheduledTime.isAfter(now)) {
        await scheduleNotification(
          id: notification.id,
          title: notification.title,
          body: notification.body,
          scheduledTime: notification.scheduledTime,
          channelId: notification.channelId,
          channelName: notification.channelName,
          saveToDataSource: false,
        );
      } else {
        await _dataSource.removeNotification(notification.id);
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String channelId,
    required String channelName,
    Importance importance = Importance.max,
    Priority priority = Priority.high,
    bool saveToDataSource = true,
  }) async {
    if (saveToDataSource) {
      final model = ScheduledNotificationModel(
        id: id,
        title: title,
        body: body,
        scheduledTime: scheduledTime,
        channelId: channelId,
        channelName: channelName,
      );
      await _dataSource.saveNotification(model);
    }

    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          importance: importance,
          priority: priority,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id: id);
    await _dataSource.removeNotification(id);
  }

  Future<bool> isNotificationScheduled(int id) async {
    final pending = await _notificationsPlugin.pendingNotificationRequests();
    return pending.any((x) => x.id == id);
  }
}
