import 'package:cine_scope/core/extensions/ref_extensions.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/data/utils/preload_backdrop.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieProvider = FutureProvider.autoDispose.family<Movie, int>((
  ref,
  id,
) async {
  ref.watch(localeProvider);
  ref.cache();

  final movie = await ref.read(movieRepositoryProvider).fetchMovieById(id: id);

  await preloadBackdrop(movie.backdropPath);

  return movie;
});
