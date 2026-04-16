import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/skeleton_placeholder.dart';
import 'package:flutter/material.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key, this.isScrollable = true});

  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: .start,
          children: [
            Expanded(flex: 12, child: const SkeletonPlaceholder()),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xxl),
                child: const SkeletonPlaceholder(),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: const SkeletonPlaceholder(),
              ),
            ),
          ],
        );
      },
    );
  }
}
