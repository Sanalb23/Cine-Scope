import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/widgets/paginated_scroll_handler.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';

class PaginatedMoviesList extends StatelessWidget {
  const PaginatedMoviesList({super.key, required this.moviesList});
  final MoviesList moviesList;

  @override
  Widget build(BuildContext context) {
    return PaginatedScrollHandler(
      onFetchMore: moviesList.onFetchMore,
      builder: (context, isFetchingMore) {
        return ListView(
          shrinkWrap: true,
          children: [
            moviesList,
            const SizedBox(height: AppSpacing.lg),
            if (isFetchingMore) const MovieListSkeleton(isScrollable: false),
          ],
        );
      },
    );
  }
}
