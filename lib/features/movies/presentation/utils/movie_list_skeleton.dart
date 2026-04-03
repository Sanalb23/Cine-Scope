import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/loading_image.dart';
import 'package:flutter/material.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
            Expanded(flex: 12, child: const LoadingImage()),

            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.md),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.inverseSurface.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.inverseSurface.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(AppSpacing.md),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
