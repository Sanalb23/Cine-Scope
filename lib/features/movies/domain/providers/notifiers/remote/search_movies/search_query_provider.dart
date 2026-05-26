import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  Timer? _debounceTimer;

  @override
  String build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });

    return '';
  }

  void setSearchQuery(String query) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 800),
      () => state = query,
    );
  }
}
