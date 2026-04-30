import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/widgets/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.movies,
    required this.onRetry,
    this.onRefresh,
  });

  final AsyncValue<List<MovieSummary>> movies;
  final VoidCallback onRetry;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return movies.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: Text(
              'No movies found',
              style: context.textTheme.headlineSmall,
            ),
          );
        }

        Widget grid = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: AppSpacing.lg,
            crossAxisSpacing: AppSpacing.lg,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        );

        if (onRefresh != null) {
          grid = RefreshIndicator(onRefresh: onRefresh!, child: grid);
        }

        return grid;
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: TryAgainLater(onPressed: onRetry)),
    );
  }
}
