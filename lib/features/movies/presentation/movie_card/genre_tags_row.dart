import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/features/genres/domain/genre_provider.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
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
    final genresMap = ref.watch(genreProvider);

    return genresMap.when(
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
