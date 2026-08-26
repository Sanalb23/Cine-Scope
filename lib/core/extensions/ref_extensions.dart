import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension RefCacheExtension on Ref {
  void cache([Duration duration = const Duration(minutes: 3)]) {
    final link = keepAlive();

    final timer = Timer(duration, () {
      link.close();
    });

    onDispose(() {
      timer.cancel();
    });
  }
}
