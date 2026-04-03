import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overflow_view/overflow_view.dart';

class GenreTagsRow extends ConsumerWidget {
  const GenreTagsRow({
    super.key,
    required this.genreIds,
    this.spacing = AppSpacing.sm,
  });

  final List<int> genreIds;
  final double spacing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Replace with actual genre provider
    final mockGenresMap = AsyncValue.data({
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Science Fiction',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    });

    return mockGenresMap.when(
      data: (data) => OverflowView.flexible(
        spacing: spacing,
        builder: (context, overflowCount) =>
            Text('+$overflowCount', style: context.textTheme.labelMedium),
        children: genreIds
            .map((id) => GenreTag(genre: data[id] ?? 'Unknown'))
            .toList(),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
