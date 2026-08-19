import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_watch_providers_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieWatchProvidersLocalDatasourceProvider =
    Provider<MovieWatchProvidersLocalDatasource>((ref) {
  final prefs = ref.watch(prefsInstanceProvider);
  return MovieWatchProvidersLocalDatasourceImpl(prefs: prefs);
});
