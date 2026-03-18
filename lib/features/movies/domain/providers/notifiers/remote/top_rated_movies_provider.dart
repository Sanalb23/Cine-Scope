import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topRatedMoviesProvider =
    AsyncNotifierProvider<TopRatedMoviesNotifier, List<MovieSummary>>(() {
      return TopRatedMoviesNotifier();
    });

class TopRatedMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return ref.read(movieRepositoryProvider).getTopRatedMovies();
  }

  Future<void> fetchTopRatedMovies() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(movieRepositoryProvider).getTopRatedMovies();
    });
  }
}
