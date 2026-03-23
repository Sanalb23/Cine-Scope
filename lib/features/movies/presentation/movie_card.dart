import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
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
                child: Ink.image(
                  image: NetworkImage(movie.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Text(
            movie.title,
            style: context.textTheme.titleLarge,
            maxLines: 1,
            overflow: .ellipsis,
          ),
        ],
      ),
    );
  }
}
