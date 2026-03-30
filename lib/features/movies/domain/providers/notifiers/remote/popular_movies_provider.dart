import 'package:cine_scope/features/movies/data/utils/preload_posters.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popularMoviesProvider =
    AsyncNotifierProvider<PopularMoviesNotifier, List<MovieSummary>>(() {
      return PopularMoviesNotifier();
    });

class PopularMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return ref.read(movieRepositoryProvider).getPopularMovies();
  }

  Future<void> fetchPopularMovies() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final movies = await ref.read(movieRepositoryProvider).getPopularMovies();

      await preloadPosters(movies);

      return movies;
    });
  }
}
