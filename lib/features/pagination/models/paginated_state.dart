class PaginatedState<T> {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;
  final bool hasError;
  final int currentPage;

  PaginatedState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.hasError = false,
    this.currentPage = 0,
  });

  PaginatedState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? hasMore,
    bool? hasError,
    int? currentPage,
  }) {
    return PaginatedState<T>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      hasError: hasError ?? this.hasError,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
