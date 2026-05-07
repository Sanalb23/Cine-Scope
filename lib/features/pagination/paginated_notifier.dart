import 'dart:async';

import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PaginatedNotifier<T> extends Notifier<PaginatedState<T>> {
  Future<List<T>> fetchItems(int page);

  @override
  PaginatedState<T> build() {
    state = PaginatedState<T>();

    unawaited(fetchMore());

    return state;
  }

  Future<void> fetchMore() async {
    if (state.isLoading || !state.hasMore || state.hasError) return;

    state = state.copyWith(isLoading: true);

    try {
      final newItems = await fetchItems(state.currentPage + 1);

      if (newItems.isEmpty) {
        state = state.copyWith(isLoading: false, hasMore: false);
      } else {
        state = state.copyWith(
          items: [...state.items, ...newItems],
          currentPage: state.currentPage + 1,
          isLoading: false,
          hasMore: true,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true);
    }
  }

  Future<void> retry() async {
    state = state.copyWith(isLoading: false, hasError: false, hasMore: true);
    await fetchMore();
  }
}
