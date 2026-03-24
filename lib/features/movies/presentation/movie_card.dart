import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/genre_tags_row.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieSummary movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      debugPrint('Movie tapped: ${movie.title}');
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
                      image: NetworkImage(movie.posterPath),
                      fit: BoxFit.cover,
                    ),
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
                      child: _InfoBadge(
                        label: movie.releaseDate.substring(0, 4),
                      ),
                    ),

                    if (movie.adult)
                      Positioned(
                        top: AppSpacing.md,
                        left: AppSpacing.md,
                        child: _InfoBadge(
                          label: '18+',
                          labelColor: context.colors.error,
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
