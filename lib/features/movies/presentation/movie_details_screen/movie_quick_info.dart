import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/extensions/duration_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MovieQuickInfo extends StatelessWidget {
  const MovieQuickInfo({
    super.key,
    required this.releaseDate,
    required this.originalLanguage,
    required this.adult,
    required this.runtime,
  });

  final String releaseDate;
  final String originalLanguage;
  final bool adult;
  final int runtime;

  @override
  Widget build(BuildContext context) {
    final runtimeString = Duration(minutes: runtime).hoursAndMinutesString;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.md,
      children: [
        Text(releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : 'N/A'),
        const _InfoRowSpacer(),
        Text(originalLanguage.toUpperCase()),
        const _InfoRowSpacer(),
        Text(runtimeString),

        if (adult) ...[
          const _InfoRowSpacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm / 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.error),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '18+',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _InfoRowSpacer extends StatelessWidget {
  const _InfoRowSpacer();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 8,
      color: context.colors.onSurface.withValues(alpha: 0.5),
    );
  }
}
