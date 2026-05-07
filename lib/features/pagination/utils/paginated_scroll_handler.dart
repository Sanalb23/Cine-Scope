import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:flutter/material.dart';

class PaginatedScrollHandler extends StatelessWidget {
  const PaginatedScrollHandler({
    super.key,
    required this.fetchCallback,
    required this.retryCallback,
    required this.state,
    required this.builder,
  });
  final VoidCallback fetchCallback;
  final VoidCallback retryCallback;
  final PaginatedState<MovieSummary> state;
  final Widget Function(
    BuildContext context,
    bool isFetchingMore,
    bool hasError,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          fetchCallback();
        }

        return false;
      },
      child: builder(context, state.isLoading, state.hasError),
    );
  }
}
