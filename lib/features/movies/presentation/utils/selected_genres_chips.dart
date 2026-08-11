import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/selected_genres_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedGenresChips extends ConsumerWidget {
  const SelectedGenresChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allGenres = ref.watch(movieGenreProvider);
    final selectedGenres = ref.watch(selectedGenresProvider);

    if (selectedGenres.isEmpty) {
      return const SizedBox.shrink();
    }

    return allGenres.maybeWhen(
      data: (genresMap) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          child: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: selectedGenres.map((genreId) {
              final genreName = genresMap[genreId];
              if (genreName == null) return const SizedBox.shrink();

              return Chip(
                label: Text(genreName),
                onDeleted: () => ref
                    .read(selectedGenresProvider.notifier)
                    .removeGenre(genreId),
              );
            }).toList(),
          ),
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
