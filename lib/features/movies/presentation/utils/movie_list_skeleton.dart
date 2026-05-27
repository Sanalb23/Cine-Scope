import 'package:cine_scope/features/movies/presentation/utils/movie_card_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_grid.dart';
import 'package:flutter/material.dart';

class MovieListSkeleton extends StatelessWidget {
  const MovieListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return MoviesGrid(
      children: List.generate(8, (_) => const MovieCardSkeleton()),
    );
  }
}
