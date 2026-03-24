import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/genre_tags_row.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final MovieSummary movie;
  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late bool isInFavorites;
  late bool isInWatchList;

  @override
  Widget build(BuildContext context) {
    final actions = <PopupMenuItem<String>>[
      PopupMenuItem(
        value: 'favorite',
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Icon(isInFavorites ? Icons.bookmark : Icons.bookmark_add_outlined),
            Text(isInFavorites ? 'Remove from favorites' : 'Add to favorites'),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'watchLater',
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Icon(
              isInWatchList ? Icons.watch_later : Icons.watch_later_outlined,
            ),
            Text(
              isInWatchList ? 'Remove from watch list' : 'Add to watch list',
            ),
          ],
        ),
      ),
    ];

    void onTap() {
      debugPrint('Movie tapped: ${widget.movie.title}');
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: Material(
              child: InkWell(
                onTap: onTap,
                child: Stack(
                  children: [
                    Ink.image(
                      image: NetworkImage(widget.movie.posterPath),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: AppSpacing.md,
                      left: AppSpacing.md,
                      child: _InfoBadge(
                        label: widget.movie.voteAverage.toStringAsFixed(1),
                        icon: Icons.star,
                      ),
                    ),

                    Positioned(
                      bottom: AppSpacing.md,
                      right: AppSpacing.md,
                      child: _InfoBadge(
                        label: widget.movie.releaseDate.substring(0, 4),
                      ),
                    ),

                    if (widget.movie.adult)
                      Positioned(
                        top: AppSpacing.md,
                        left: AppSpacing.md,
                        child: _InfoBadge(
                          label: '18+',
                          labelColor: context.colors.error,
                        ),
                      ),

                    Positioned(
                      top: AppSpacing.md,
                      right: AppSpacing.md,
                      child: PopupMenuButton(
                        itemBuilder: (context) {
                          return actions;
                        },
                        onSelected: (value) {
                          switch (value) {
                            case 'favorite':
                              setState(() {
                                isInFavorites = !isInFavorites;
                              });
                              break;
                            case 'watchLater':
                              setState(() {
                                isInWatchList = !isInWatchList;
                              });
                              break;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Column(
            spacing: AppSpacing.sm,
            crossAxisAlignment: .start,
            children: [
              Text(
                widget.movie.title,
                style: context.textTheme.titleLarge,
                maxLines: 1,
                overflow: .ellipsis,
              ),
              GenreTagsRow(genreIds: widget.movie.genreIds),
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
