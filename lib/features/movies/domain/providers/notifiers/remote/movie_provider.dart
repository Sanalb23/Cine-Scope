import 'dart:async';
import 'package:cine_scope/features/movies/data/utils/preload_backdrop.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider = FutureProvider.autoDispose.family<Movie, int>((
  ref,
  id,
) async {
  final link = ref.keepAlive();

  final timer = Timer(const Duration(minutes: 3), () {
    link.close();
  });

  ref.onDispose(() => timer.cancel());

  final movie = await ref.read(movieRepositoryProvider).getMovieById(id: id);

  await preloadBackdrop(movie.backdropPath);

  return movie;
});
