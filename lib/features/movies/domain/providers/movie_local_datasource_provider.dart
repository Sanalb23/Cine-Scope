import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_local_datasource_impl.dart';
import 'package:cine_scope/features/movies/domain/providers/prefs_instance_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieLocalDatasourceProvider = Provider.autoDispose<MovieLocalDatasource>(
  (ref) {
    final prefs = ref.watch(prefsInstanceProvider);
    return MovieLocalDatasourceImpl(prefs: prefs);
  },
);
