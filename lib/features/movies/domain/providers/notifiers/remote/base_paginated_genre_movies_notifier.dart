import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/selected_genres_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/base_paginated_movies_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';

abstract class BasePaginatedGenreMoviesNotifier extends BasePaginatedMoviesNotifier {
  @override
  PaginatedState<MovieSummary> build() {
    ref.watch(selectedGenresProvider);
    return super.build();
  }

  List<int> get genreIds => ref.read(selectedGenresProvider);
}
