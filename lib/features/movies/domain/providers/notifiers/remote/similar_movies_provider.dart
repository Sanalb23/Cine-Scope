import 'dart:async';
import 'package:cine_scope/features/movies/data/utils/preload_posters.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.autoDispose
    .family<List<MovieSummary>, int>((ref, id) async {
      final link = ref.keepAlive();

      final timer = Timer(const Duration(minutes: 3), () {
        link.close();
      });

      ref.onDispose(() => timer.cancel());

      final movies = await ref
          .read(movieRepositoryProvider)
          .getSimilarMovies(id: id);

      await preloadPosters(movies);

      return movies;
    });
