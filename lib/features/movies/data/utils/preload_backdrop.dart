import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> preloadBackdrop(String? path) async {
  if (path == null) return;
  try {
    await DefaultCacheManager().downloadFile(path);
  } catch (e) {
    // ignore
  }
}
