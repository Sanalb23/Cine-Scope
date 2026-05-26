import 'package:cine_scope/features/movies/domain/providers/movie_genre_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreProvider = FutureProvider<Map<int, String>>((ref) {
  final datasource = ref.watch(movieGenreDatasourceProvider);
  return datasource.getMovieGenres();
});
