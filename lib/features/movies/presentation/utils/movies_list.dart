import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_card_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_grid.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.state,
    required this.retryCallback,
    this.emptyText,
  });

  final PaginatedState<MovieSummary> state;
  final VoidCallback retryCallback;
  final String? emptyText;

  @override
  Widget build(BuildContext context) {
    if (state.items.isEmpty && !state.isLoading && !state.hasError) {
      return Center(child: Text(emptyText ?? 'no_movies_found'.tr()));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.xl,
      children: [
        MoviesGrid(
          children: [
            ...state.items.map((movie) => MovieCard(movie: movie)),
            if (state.isLoading)
              ...List.generate(20, (_) => const MovieCardSkeleton()),
          ],
        ),

        if (state.hasError) TryAgainLater(onPressed: retryCallback),
      ],
    );
  }
}
