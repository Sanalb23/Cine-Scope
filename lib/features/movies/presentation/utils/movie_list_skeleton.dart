import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:flutter/material.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      itemCount: 8,
      itemBuilder: (_, __) {
        return Column(
          spacing: AppSpacing.sm,
          crossAxisAlignment: .start,
          children: [
            Expanded(flex: 14, child: const SkeletonPlaceholder()),

            const Expanded(flex: 2, child: SkeletonPlaceholder()),

            const Expanded(
              child: Row(
                spacing: AppSpacing.sm,
                children: [
                  Flexible(flex: 3, child: SkeletonPlaceholder()),
                  Flexible(flex: 3, child: SkeletonPlaceholder()),
                  Flexible(flex: 2, child: SkeletonPlaceholder()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
