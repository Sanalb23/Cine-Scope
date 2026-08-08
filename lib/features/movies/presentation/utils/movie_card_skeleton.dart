import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_tags_skeleton.dart';
import 'package:flutter/material.dart';

class MovieCardSkeleton extends StatelessWidget {
  const MovieCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      spacing: AppSpacing.sm,
      children: [
        const Expanded(flex: 14, child: SkeletonPlaceholder()),

        const Expanded(flex: 2, child: SkeletonPlaceholder()),

        const GenreTagsSkeleton(),
      ],
    );
  }
}
