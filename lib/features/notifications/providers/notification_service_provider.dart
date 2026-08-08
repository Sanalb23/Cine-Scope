import 'package:cine_scope/features/notifications/providers/notification_local_datasource_provider.dart';
import 'package:cine_scope/features/notifications/services/notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationServiceProvider = FutureProvider<NotificationService>((
  ref,
) async {
  final notificationLocalDataSource = ref.watch(
    notificationLocalDataSourceProvider,
  );
  final notificationService = NotificationService(notificationLocalDataSource);
  await notificationService.initNotification();
  return notificationService;
});
