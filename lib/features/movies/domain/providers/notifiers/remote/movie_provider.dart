import 'dart:async';

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

  return ref.read(movieRepositoryProvider).getMovieById(id: id);
});
