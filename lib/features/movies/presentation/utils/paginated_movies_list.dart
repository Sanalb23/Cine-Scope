import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';

class PaginatedMoviesList extends StatelessWidget {
  const PaginatedMoviesList({
    super.key,
    required this.fetchCallback,
    required this.retryCallback,
    required this.state,
    this.isScrollable = true,
  });
  final VoidCallback fetchCallback;
  final VoidCallback retryCallback;
  final PaginatedState<MovieSummary> state;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return PaginatedScrollHandler(
      fetchCallback: fetchCallback,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: isScrollable
            ? AlwaysScrollableScrollPhysics()
            : NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (state.items.isNotEmpty) ...[
            MoviesList(movies: state.items),
            const SizedBox(height: AppSpacing.lg),
          ],
          if (state.isLoading) const MovieListSkeleton(),
          if (state.hasError) TryAgainLater(onPressed: retryCallback),
        ],
      ),
    );
  }
}
