import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
      Placeholder(),
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return movies[index];
      },
    );
  }
}
