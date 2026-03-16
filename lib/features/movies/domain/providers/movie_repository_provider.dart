
import 'package:cine_scope/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/movie_repository.dart';

final movieRepositoryProvider = Provider.autoDispose<MovieRepository>((ref) {
  final datasource = ref.watch(movieDatasourceProvider);
  return MovieRepositoryImpl(datasource: datasource);
});