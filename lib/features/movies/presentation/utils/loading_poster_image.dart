import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoadingPosterImage extends StatelessWidget {
  const LoadingPosterImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.inverseSurface.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
