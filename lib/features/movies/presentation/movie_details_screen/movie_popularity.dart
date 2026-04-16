import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class MoviePopularity extends StatelessWidget {
  const MoviePopularity({super.key, required this.popularity});

  final double popularity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: .min,
        spacing: AppSpacing.sm,
        children: [
          Icon(
            Icons.local_fire_department_outlined,
            size: 16,
            color: context.colors.error,
          ),
          Text(
            'POPULARITY: ${popularity.toStringAsFixed(1)}',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.error,
            ),
          ),
        ],
      ),
    );
  }
}
