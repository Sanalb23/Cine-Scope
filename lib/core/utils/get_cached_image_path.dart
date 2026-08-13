import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<String> getCachedImagePath(String url) async {
  try {
    final file = await DefaultCacheManager().getSingleFile(url);

    return file.path;
  } catch (_) {
    return '';
  }
}
