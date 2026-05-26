import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:flutter/widgets.dart';

class GenreTagsSkeleton extends StatelessWidget {
  const GenreTagsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.sm,
      children: [
        Flexible(flex: 3, child: SkeletonPlaceholder()),
        Flexible(flex: 3, child: SkeletonPlaceholder()),
        Flexible(flex: 2, child: SkeletonPlaceholder()),
      ],
    );
  }
}
