import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  const GenreTag({super.key, required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm / 2,
        ),
        child: Text(genre, style: context.textTheme.labelMedium),
      ),
    );
  }
}
