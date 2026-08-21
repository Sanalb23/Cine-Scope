import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_genre_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreLocalDataSourceProvider =
    Provider<MovieGenreLocalDataSource>((ref) {
  final prefs = ref.watch(prefsInstanceProvider);
  return MovieGenreLocalDataSourceImpl(prefs: prefs);
});
