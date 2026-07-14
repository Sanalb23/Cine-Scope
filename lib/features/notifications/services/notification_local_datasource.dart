import 'package:cine_scope/features/notifications/models/scheduled_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationLocalDataSource {
  final SharedPreferences _prefs;
  static const _key = 'scheduled_notifications';

  NotificationLocalDataSource(this._prefs);

  Future<void> saveNotification(ScheduledNotificationModel notification) async {
    final notifications = getScheduledNotifications();
    notifications.removeWhere((n) => n.id == notification.id);
    notifications.add(notification);
    
    final jsonList = notifications.map((n) => n.toJson()).toList();
    await _prefs.setStringList(_key, jsonList);
  }

  Future<void> removeNotification(int id) async {
    final notifications = getScheduledNotifications();
    notifications.removeWhere((n) => n.id == id);
    
    final jsonList = notifications.map((n) => n.toJson()).toList();
    await _prefs.setStringList(_key, jsonList);
  }

  List<ScheduledNotificationModel> getScheduledNotifications() {
    final jsonList = _prefs.getStringList(_key) ?? [];
    return jsonList.map((source) => ScheduledNotificationModel.fromJson(source)).toList();
  }
}
