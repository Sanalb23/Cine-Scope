import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  const MovieOverview({super.key, required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text('Overview', style: context.textTheme.headlineSmall),
        Text(
          overview.isNotEmpty ? overview : 'No overview available',
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
