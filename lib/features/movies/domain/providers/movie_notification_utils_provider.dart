import 'package:cine_scope/features/notifications/providers/notification_service_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_notifications_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieNotificationUtilsProvider =
    FutureProvider<MovieNotificationUtils>((ref) async {
  final notificationService =
      await ref.watch(notificationServiceProvider.future);

  return MovieNotificationUtils(notificationService: notificationService);
});
