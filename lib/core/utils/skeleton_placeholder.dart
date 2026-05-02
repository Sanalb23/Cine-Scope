import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonPlaceholder extends StatelessWidget {
  const SkeletonPlaceholder({super.key, this.isCircle = false});
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.lerp(
        context.theme.scaffoldBackgroundColor,
        context.colors.inverseSurface,
        0.1,
      )!,
      highlightColor: context.colors.inverseSurface.withValues(alpha: 0.5),
      child: Container(
        decoration: BoxDecoration(
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          color: Colors.white,
          borderRadius: isCircle ? null : BorderRadius.circular(8),
        ),
      ),
    );
  }
}
