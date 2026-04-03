import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {
  const MovieRating({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  final double voteAverage;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    final formattedVoteCount = switch (voteCount) {
      < 10000 => voteCount.toString(),
      < 1000000 => '${(voteCount / 1000).truncate()}K',
      < 1000000000 => '${(voteCount / 1000000).truncate()}M',
      _ => voteCount.toString(),
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        Icon(Icons.star, color: Colors.amber),
        Text(
          voteAverage.toStringAsFixed(1),
          style: context.textTheme.bodyLarge,
        ),
        Text(
          '($formattedVoteCount votes)',
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}
