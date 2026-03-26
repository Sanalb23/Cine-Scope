import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    AsyncNotifierProvider<FavoriteMoviesNotifier, List<MovieSummary>>(() {
      return FavoriteMoviesNotifier();
    });

final isFavoriteProvider = Provider.family<bool, int>((ref, id) {
  final favorites = ref.watch(favoriteMoviesProvider);
  return favorites.value?.any((m) => m.id == id) ?? false;
});

class FavoriteMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  @override
  Future<List<MovieSummary>> build() async {
    return await ref.watch(movieRepositoryProvider).getFavorites();
  }

  Future<void> toggleFavorite(Movie movie) async {
    final isFavorite = ref.read(isFavoriteProvider(movie.id));

    if (isFavorite) {
      await ref.read(movieRepositoryProvider).removeFavorite(movie.id);
    } else {
      await ref.read(movieRepositoryProvider).addFavorite(movie.id);
    }

    state = AsyncData(await ref.read(movieRepositoryProvider).getFavorites());
  }
}
