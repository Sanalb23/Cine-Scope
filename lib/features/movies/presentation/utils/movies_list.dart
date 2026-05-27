import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_card_skeleton.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies, this.isLoading = false});

  final List<MovieSummary> movies;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = (context.screenWidth / 160);

    return GridView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount.clamp(2, 6).floor(),
        childAspectRatio: 0.6,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      children: [
        ...movies.map((movie) => MovieCard(movie: movie)),
        if (isLoading) ...List.generate(20, (_) => const MovieCardSkeleton()),
      ],
    );
  }
}
