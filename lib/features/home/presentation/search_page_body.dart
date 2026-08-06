import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/home/presentation/utils/search_movies_list.dart';
import 'package:flutter/material.dart';

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: const MovieSearchBar(),
        ),
        const Expanded(child: SearchMoviesList()),
      ],
    );
  }
}
