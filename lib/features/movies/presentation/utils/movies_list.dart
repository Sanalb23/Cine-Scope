import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesList extends ConsumerWidget {
  const MoviesList({
    super.key,
    required this.movies,
    required this.onFetchMore,
  });

  final AsyncValue<List<MovieSummary>> movies;
  final VoidCallback onFetchMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return movies.when(
      data: (movies) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent * 0.9) {
              onFetchMore();
            }
            return false;
          },
          child: GridView.builder(
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
          ),
        );
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
