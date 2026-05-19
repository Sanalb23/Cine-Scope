import 'package:cine_scope/core/providers/notification_service_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_notifications_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieNotificationUtilsProvider = Provider<MovieNotificationUtils>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);

  return MovieNotificationUtils(notificationService: notificationService);
});
