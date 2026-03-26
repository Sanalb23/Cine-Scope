import 'package:cine_scope/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_local_datasource_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_remote_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/movie_repository.dart';

final movieRepositoryProvider = Provider.autoDispose<MovieRepository>((ref) {
  final remoteDatasource = ref.watch(movieRemoteDatasourceProvider);
  final localDatasource = ref.watch(movieLocalDatasourceProvider);
  return MovieRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
});
