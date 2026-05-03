import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies, required this.onRetry});

  final AsyncValue<List<MovieSummary>> movies;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return movies.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: Text(
              'no_movies_found'.tr(),
              style: context.textTheme.headlineSmall,
            ),
          );
        }

        Widget grid = GridView.builder(
          padding: EdgeInsets.zero,
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

        return grid;
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: TryAgainLater(onPressed: onRetry)),
    );
  }
}
