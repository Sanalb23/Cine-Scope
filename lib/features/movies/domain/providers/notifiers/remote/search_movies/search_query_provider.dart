import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setSearchQuery(String query) async {
    bool isCancelled = false;

    ref.onDispose(() => isCancelled = true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (isCancelled) return;

    state = query;
  }
}
