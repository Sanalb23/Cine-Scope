import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:overflow_view/overflow_view.dart';

class GenreTagsRow extends StatelessWidget {
  const GenreTagsRow({super.key, required this.genreIds});

  final List<int> genreIds;

  @override
  Widget build(BuildContext context) {
    return OverflowView.flexible(
      spacing: AppSpacing.sm,
      builder: (context, overflowCount) =>
          Text('+$overflowCount', style: context.textTheme.labelMedium),
      children: genreIds
          .map(
            (id) => Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm / 2,
                ),
                child: Text(
                  id.toString(),
                  style: context.textTheme.labelMedium,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
