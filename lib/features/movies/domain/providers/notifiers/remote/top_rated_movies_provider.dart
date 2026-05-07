import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/pagination/paginated_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final topRatedMoviesProvider =
    NotifierProvider<TopRatedMoviesNotifier, PaginatedState<MovieSummary>>(
      TopRatedMoviesNotifier.new,
    );

class TopRatedMoviesNotifier extends PaginatedNotifier<MovieSummary> {
  @override
  Future<List<MovieSummary>> fetchItems(int page) async {
    return await ref
        .read(movieRepositoryProvider)
        .getTopRatedMovies(page: page);
  }
}
