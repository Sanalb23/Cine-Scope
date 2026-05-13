import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_favorite_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_in_watch_list_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/genre_tags_row.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_details_screen.dart';
import 'package:cine_scope/features/movies/presentation/utils/confirm_removal_dialog.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_poster.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieCard extends ConsumerWidget {
  final MovieSummary movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInFavorites = ref.watch(isFavoriteProvider(movie.id));
    final isInWatchList = ref.watch(isInWatchListProvider(movie.id));

    final actions = <PopupMenuItem<String>>[
      PopupMenuItem(
        value: 'favorite',
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Icon(isInFavorites ? Icons.bookmark : Icons.bookmark_add_outlined),
            Text(
              isInFavorites
                  ? 'remove_from'.tr(args: ['favorites'.tr()])
                  : 'add_to'.tr(args: ['favorites'.tr()]),
            ),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'watchList',
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Icon(
              isInWatchList ? Icons.watch_later : Icons.watch_later_outlined,
            ),
            Text(
              isInWatchList
                  ? 'remove_from'.tr(args: ['watch_list'.tr()])
                  : 'add_to'.tr(args: ['watch_list'.tr()]),
            ),
          ],
        ),
      ),
    ];

    void onTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieDetailsScreen(id: movie.id),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: Stack(
              children: [
                MoviePoster(posterPath: movie.posterPath),

                Positioned(
                  bottom: AppSpacing.md,
                  left: AppSpacing.md,
                  child: _InfoBadge(
                    label: movie.voteAverage.toStringAsFixed(1),
                    icon: Icons.star,
                  ),
                ),

                Positioned(
                  bottom: AppSpacing.md,
                  right: AppSpacing.md,
                  child: _InfoBadge(label: '${movie.releaseDate.year}'),
                ),

                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(onTap: onTap),
                  ),
                ),

                Positioned(
                  top: AppSpacing.md,
                  right: AppSpacing.md,
                  child: PopupMenuButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        context.colors.surface.withValues(alpha: 0.85),
                      ),
                    ),
                    itemBuilder: (context) {
                      return actions;
                    },
                    onSelected: (value) async {
                      switch (value) {
                        case 'favorite':
                          if (isInFavorites &&
                              !(await confirmRemoval(
                                context,
                                'favorites',
                                movie.title,
                              ))) {
                            break;
                          }

                          ref
                              .read(isFavoriteProvider(movie.id).notifier)
                              .toggleFavorite();
                          break;
                        case 'watchList':
                          if (isInWatchList &&
                              !(await confirmRemoval(
                                context,
                                'watch_list',
                                movie.title,
                              ))) {
                            break;
                          }

                          ref
                              .read(isInWatchListProvider(movie.id).notifier)
                              .toggleWatchList();
                          break;
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          Column(
            spacing: AppSpacing.sm,
            crossAxisAlignment: .start,
            children: [
              Text(
                movie.title,
                style: context.textTheme.titleLarge,
                maxLines: 1,
                overflow: .ellipsis,
              ),
              GenreTagsRow(genreIds: movie.genreIds),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({required this.label, this.icon, this.labelColor});

  final String label;
  final Color? labelColor;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    const backgroundAlpha = 0.85;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface.withValues(alpha: backgroundAlpha),
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          if (icon != null) Icon(icon, size: 16),
          Text(
            label,
            style: context.textTheme.labelLarge?.copyWith(color: labelColor),
          ),
        ],
      ),
    );
  }
}
