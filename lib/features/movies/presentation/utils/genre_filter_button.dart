import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/selected_genres_provider.dart';

class GenreFilterButton extends ConsumerWidget {
  const GenreFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(movieGenreProvider);
    final selectedGenres = ref.watch(selectedGenresProvider);

    final clearGenre = PopupMenuItem(
      child: Row(
        spacing: AppSpacing.lg,
        children: [Icon(Icons.clear), Text('clear_filter'.tr())],
      ),
      onTap: () => ref.read(selectedGenresProvider.notifier).clearGenres(),
    );

    return genres.when(
      data: (genres) {
        return PopupMenuButton(
          tooltip: 'filter_by_genre'.tr(),
          icon: const Icon(Icons.label_outline),
          itemBuilder: (context) {
            return [
              if (selectedGenres.isNotEmpty) clearGenre,
              ...genres.entries.map((entry) {
                return CheckedPopupMenuItem<int>(
                  value: entry.key,
                  checked: selectedGenres.contains(entry.key),
                  child: Text(entry.value),
                );
              }),
            ];
          },
          onSelected: (value) {
            final currentState = ref.read(selectedGenresProvider);
            if (currentState.contains(value)) {
              ref.read(selectedGenresProvider.notifier).removeGenre(value);
            } else {
              ref.read(selectedGenresProvider.notifier).addGenre(value);
            }
          },
        );
      },
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SkeletonPlaceholder(isCircle: true),
    );
  }
}
