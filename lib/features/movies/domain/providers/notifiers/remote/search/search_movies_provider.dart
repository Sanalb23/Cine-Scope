import 'dart:async';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchMoviesProvider = FutureProvider.autoDispose
    .family<List<MovieSummary>, String>((ref, query) async {
      if (query.isEmpty) return [];

      bool isCancelled = false;
      ref.onDispose(() => isCancelled = true);

      await Future.delayed(const Duration(milliseconds: 500));

      if (isCancelled) return [];

      final state = ref.keepAlive();
      final timer = Timer(const Duration(minutes: 3), () {
        state.close();
      });

      ref.onDispose(() => timer.cancel());

      final repository = ref.read(movieRepositoryProvider);
      final movies = await repository.searchMovie(query: query);

      return movies;
    });
