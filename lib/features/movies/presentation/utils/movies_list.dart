import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_card_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_grid.dart';
import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies, this.isLoading = false});

  final List<MovieSummary> movies;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MoviesGrid(
      children: [
        ...movies.map((movie) => MovieCard(movie: movie)),
        if (isLoading) ...List.generate(20, (_) => const MovieCardSkeleton()),
      ],
    );
  }
}
