import 'package:cine_scope/core/features/genres/domain/genre_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genreProvider = FutureProvider<Map<int, String>>((ref) {
  final datasource = ref.watch(genreDatasourceProvider);
  return datasource.getMovieGenres();
});
