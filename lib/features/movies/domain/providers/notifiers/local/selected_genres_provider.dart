import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedGenresProvider =
    NotifierProvider<SelectedGenresNotifier, List<int>>(
      SelectedGenresNotifier.new,
    );

class SelectedGenresNotifier extends Notifier<List<int>> {
  @override
  List<int> build() {
    return [];
  }

  void addGenre(int genreId) {
    if (!state.contains(genreId)) {
      state = [...state, genreId];
    }
  }

  void removeGenre(int genreId) {
    state = state.where((id) => id != genreId).toList();
  }

  void clearGenres() {
    state = [];
  }
}
