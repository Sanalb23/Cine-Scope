import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider =
    NotifierProvider.autoDispose<SearchQueryNotifier, String>(
      SearchQueryNotifier.new,
    );

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void setSearchQuery(String query) {
    state = query;
  }
}
