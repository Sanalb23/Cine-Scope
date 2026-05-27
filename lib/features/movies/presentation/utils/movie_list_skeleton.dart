import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_card_skeleton.dart';
import 'package:flutter/material.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      children: List.generate(8, (_) => const MovieCardSkeleton()),
    );
  }
}
