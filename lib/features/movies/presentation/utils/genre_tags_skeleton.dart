import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GenreTagsSkeleton extends StatelessWidget {
  const GenreTagsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.lerp(
        context.theme.scaffoldBackgroundColor,
        context.colors.inverseSurface,
        0.1,
      )!,
      highlightColor: context.colors.inverseSurface.withValues(alpha: 0.5),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(flex: 3, child: _SkeletonTag()),
          Expanded(flex: 3, child: _SkeletonTag()),
          Expanded(flex: 2, child: _SkeletonTag()),
        ],
      ),
    );
  }
}

class _SkeletonTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm / 2,
        ),
        child: Text('', style: context.textTheme.labelMedium),
      ),
    );
  }
}
