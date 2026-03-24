import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/skeletons/movie_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularMoviesList extends ConsumerWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(_mockListProvider);

    return movies.when(
      data: (movies) {
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
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}

final _mockListProvider = FutureProvider<List<Widget>>((ref) async {
  await Future.delayed(const Duration(seconds: 3));

  final mockMovies = [
    MovieSummary(
      id: 550,
      title: 'Fight Club',
      posterPath:
          'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
      voteAverage: 8.433,
      releaseDate: '1999-10-15',
      adult: false,
      genreIds: [18, 53, 35],
    ),
    MovieSummary(
      id: 680,
      title: 'Pulp Fiction',
      posterPath:
          'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
      voteAverage: 8.49,
      releaseDate: '1994-09-10',
      adult: false,
      genreIds: [53, 80],
    ),
    MovieSummary(
      id: 13,
      title: 'Forrest Gump',
      posterPath:
          'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
      voteAverage: 8.47,
      releaseDate: '1994-06-23',
      adult: false,
      genreIds: [35, 18, 10749],
    ),
  ];

  return mockMovies.map((movie) => MovieCard(movie: movie)).toList();
});
