import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:cine_scope/features/notifications/services/notification_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationLocalDataSourceProvider =
    Provider<NotificationLocalDataSource>((ref) {
  final prefs = ref.watch(prefsInstanceProvider);
  return NotificationLocalDataSource(prefs);
});
