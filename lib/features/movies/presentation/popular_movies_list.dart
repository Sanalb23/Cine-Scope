import 'package:cine_scope/core/theme/app_theme.dart';
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

  return List.generate(10, (index) => Placeholder());
});
