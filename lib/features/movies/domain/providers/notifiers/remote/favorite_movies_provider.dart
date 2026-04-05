import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    AsyncNotifierProvider<FavoriteMoviesNotifier, List<MovieSummary>>(() {
      return FavoriteMoviesNotifier();
    });

final isFavoriteProvider = Provider.family.autoDispose<bool, int>((ref, id) {
  return ref.watch(movieRepositoryProvider).isFavorite(id);
});

class FavoriteMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getFavoriteMovies();
  }

  Future<void> toggleFavorite(int id) async {
    final isFavorite = ref.read(movieRepositoryProvider).isFavorite(id);

    if (isFavorite) {
      await ref.read(movieRepositoryProvider).removeFavorite(id);
    } else {
      await ref.read(movieRepositoryProvider).addFavorite(id);
    }

    state = AsyncData(
      await ref.read(movieRepositoryProvider).getFavoriteMovies(),
    );
  }
}
