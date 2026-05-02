import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class TrailerButton extends StatelessWidget {
  final String? trailerPath;
  const TrailerButton({super.key, required this.trailerPath});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: trailerPath == null
          ? null
          : () {
              //TODO: implement url launcher
            },
      child: trailerPath != null
          ? Row(
              mainAxisSize: .min,
              spacing: AppSpacing.md,
              children: [
                Icon(Icons.play_arrow),
                Text('Watch trailer', style: context.textTheme.titleMedium),
              ],
            )
          : Text(
              'No trailer available',
              style: context.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
    );
  }
}
