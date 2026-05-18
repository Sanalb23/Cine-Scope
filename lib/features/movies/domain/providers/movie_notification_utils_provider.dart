import 'package:cine_scope/features/movies/presentation/utils/movie_notifications_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieNotificationUtilsProvider = Provider<MovieNotificationUtils>((ref) {
  return MovieNotificationUtils();
});
