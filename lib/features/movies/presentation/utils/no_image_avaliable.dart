import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class NoImageAvaliable extends StatelessWidget {
  const NoImageAvaliable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      spacing: AppSpacing.sm,
      children: [
        const Icon(Icons.error),
        Text('No Image available', style: context.textTheme.labelSmall),
      ],
    );
  }
}
