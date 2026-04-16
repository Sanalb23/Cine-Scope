import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class TryAgainLater extends StatelessWidget {
  const TryAgainLater({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      spacing: AppSpacing.md,
      children: [
        Icon(Icons.error_outline, size: 48),
        Text('Error', style: context.textTheme.headlineSmall),
        Text('Please try again later', style: context.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        ElevatedButton(onPressed: onPressed, child: Text('Retry')),
      ],
    );
  }
}
