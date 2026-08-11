import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  const GenreTag({super.key, required this.genre, this.onTap});

  final String genre;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm / 2,
          ),
          child: Text(genre, style: context.textTheme.labelMedium),
        ),
      ),
    );
  }
}
