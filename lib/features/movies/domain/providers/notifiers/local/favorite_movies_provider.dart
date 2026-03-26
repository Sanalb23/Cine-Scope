import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    NotifierProvider<FavoriteMoviesNotifier, List<MovieSummary>>(() {
      return FavoriteMoviesNotifier();
    });

final isFavoriteProvider = Provider.family<bool, int>((ref, id) {
  final favorites = ref.watch(favoriteMoviesProvider);
  return favorites.any((m) => m.id == id);
});

class FavoriteMoviesNotifier extends Notifier<List<MovieSummary>> {
  @override
  List<MovieSummary> build() {
    return ref.watch(movieRepositoryProvider).getFavorites();
  }

  Future<void> addFavorite(Movie movie) async {
    await ref.read(movieRepositoryProvider).addFavorite(movie);

    state = ref.read(movieRepositoryProvider).getFavorites();
  }

  Future<void> removeFavorite(int id) async {
    await ref.read(movieRepositoryProvider).removeFavorite(id);

    state = ref.read(movieRepositoryProvider).getFavorites();
  }
}
