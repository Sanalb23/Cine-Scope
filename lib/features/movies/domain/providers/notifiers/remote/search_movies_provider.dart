import 'dart:async';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider =
    AsyncNotifierProvider<SearchMoviesNotifier, List<MovieSummary>>(() {
      return SearchMoviesNotifier();
    });

class SearchMoviesNotifier extends AsyncNotifier<List<MovieSummary>> {
  final _cache = <String, List<MovieSummary>>{};

  @override
  Future<List<MovieSummary>> build() async {
    return [];
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    if (_cache.containsKey(query)) {
      state = AsyncData(_cache[query]!);
      return;
    }

    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 500));

    state = await AsyncValue.guard(() async {
      final results = await ref
          .read(movieRepositoryProvider)
          .searchMovie(query: query);
      _cache[query] = results;
      return results;
    });
  }
}
