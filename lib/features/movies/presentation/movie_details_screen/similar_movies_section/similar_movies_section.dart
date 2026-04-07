import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.lg,
      children: [
        Text('Similar Movies', style: context.textTheme.headlineSmall),
        const MovieListSkeleton(isScrollable: false),
      ],
    );
  }
}
