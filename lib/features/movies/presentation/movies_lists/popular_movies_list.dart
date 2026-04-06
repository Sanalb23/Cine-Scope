import 'package:cine_scope/features/movies/domain/providers/temp/mock_movies_list_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularMoviesList extends ConsumerWidget {
  const PopularMoviesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MoviesList(
      movies: ref.watch(mockMoviesListProvider),
      onFetchMore: () {
        //TODO: Implement fetch more
      },
    );
  }
}
