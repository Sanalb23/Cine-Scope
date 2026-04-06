import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteProvider = NotifierProvider.autoDispose
    .family<IsFavoriteNotifier, bool, int>(IsFavoriteNotifier.new);

class IsFavoriteNotifier extends Notifier<bool> {
  IsFavoriteNotifier(this.id);
  final int id;
  @override
  bool build() {
    return ref.watch(movieRepositoryProvider).isFavorite(id);
  }

  void toggleFavorite() {
    final isFavorite = ref.read(movieRepositoryProvider).isFavorite(id);

    if (isFavorite) {
      ref.read(movieRepositoryProvider).removeFavorite(id);
    } else {
      ref.read(movieRepositoryProvider).addFavorite(id);
    }

    state = ref.read(movieRepositoryProvider).isFavorite(id);
  }
}
