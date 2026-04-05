import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesList extends ConsumerWidget {
  const MoviesList({super.key, required this.movies});

  final AsyncValue<List<MovieSummary>> movies;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return movies.when(
      data: (movies) {
        return GridView.builder(
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
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
