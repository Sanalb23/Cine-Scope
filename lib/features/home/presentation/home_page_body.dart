import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/movies_by_category_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/selected_genres_provider.dart';

class HomePageBody extends ConsumerWidget {
  const HomePageBody({super.key});

  PopupMenuItem<MovieListCategory> _buildPopupMenuItem(
    MovieListCategory category,
  ) {
    return PopupMenuItem(
      value: category,
      child: Row(
        spacing: AppSpacing.sm,
        children: [Icon(category.icon), Text(category.title)],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(moviesByCategoryProvider);

    final popupMenuButton = PopupMenuButton<MovieListCategory>(
      tooltip: 'explore_movies'.tr(),
      icon: const Icon(Icons.filter_list),
      itemBuilder: (context) {
        return [
          _buildPopupMenuItem(MovieListCategory.popular),
          _buildPopupMenuItem(MovieListCategory.topRated),
          _buildPopupMenuItem(MovieListCategory.upcoming),
        ];
      },
      onSelected: (value) {
        ref.read(moviesByCategoryProvider.notifier).switchCategory(value);
      },
    );

    final selectedGenres = ref.watch(selectedGenresProvider);

    final clearGenre = PopupMenuItem(
      child: Row(
        spacing: AppSpacing.lg,
        children: [Icon(Icons.clear), Text('clear_filter'.tr())],
      ),
      onTap: () => ref.read(selectedGenresProvider.notifier).clearGenres(),
    );

    final genrePopup = ref
        .watch(movieGenreProvider)
        .when(
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

    return PaginatedMoviesList(
      fetchCallback: listState.fetchCallback,
      retryCallback: listState.retryCallback,
      state: listState.state,
      title: listState.category.title,
      actions: [genrePopup, popupMenuButton],
    );
  }
}
