import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class MovieQuickInfo extends StatelessWidget {
  const MovieQuickInfo({
    super.key,
    required this.releaseDate,
    required this.originalLanguage,
  });

  final String releaseDate;
  final String originalLanguage;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.md,
      children: [
        Text(releaseDate),
        const _InfoRowSpacer(),
        Text(originalLanguage.toUpperCase()),
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
