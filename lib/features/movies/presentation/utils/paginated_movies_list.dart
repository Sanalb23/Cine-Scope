import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/paginated_scroll_handler.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginatedMoviesList extends StatelessWidget {
  const PaginatedMoviesList({
    super.key,
    required this.onFetchMore,
    required this.onRetry,
    required this.movies,
  });
  final Future<List<dynamic>> Function() onFetchMore;
  final void Function() onRetry;
  final AsyncValue<List<MovieSummary>> movies;

  @override
  Widget build(BuildContext context) {
    return PaginatedScrollHandler(
      onFetchMore: onFetchMore,
      builder: (context, isFetchingMore) {
        return ListView(
          shrinkWrap: true,
          children: [
            MoviesList(movies: movies, onRetry: onRetry),

            if (isFetchingMore) ...{
              const SizedBox(height: AppSpacing.lg),
              const MovieListSkeleton(),
            },
          ],
        );
      },
    );
  }
}
