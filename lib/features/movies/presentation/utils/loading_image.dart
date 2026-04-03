import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.lerp(
          context.theme.scaffoldBackgroundColor,
          context.colors.inverseSurface,
          0.1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
