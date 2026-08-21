import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreProvider = FutureProvider<Map<int, String>>((ref) {
  final repository = ref.watch(movieGenreRepositoryProvider);
  final language = ref.watch(localeProvider).toLanguageTag();
  return repository.getMovieGenres(language: language);
});
