import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    AsyncNotifierProvider.autoDispose<
      FavoriteMoviesNotifier,
      List<MovieSummary>
    >(() {
      return FavoriteMoviesNotifier();
    });

class FavoriteMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getFavoriteMovies();
  }

  Future<void> getFavoriteMovies() async {
    state = AsyncData(
      await ref.watch(movieRepositoryProvider).getFavoriteMovies(),
    );
  }
}
