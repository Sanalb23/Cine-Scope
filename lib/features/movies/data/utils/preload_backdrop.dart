import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> preloadBackdrop(String path) async {
  try {
    await DefaultCacheManager().downloadFile(path);
  } catch (e) {
    // ignore
  }
}
