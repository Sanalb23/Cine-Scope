import 'package:cine_scope/features/movies/data/repositories/movie_watch_providers_repository_impl.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_remote_datasource_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_local_datasource_provider.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_watch_providers_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieWatchProvidersRepositoryProvider =
    Provider<MovieWatchProvidersRepository>((ref) {
  final remoteDatasource = ref.watch(movieWatchProvidersRemoteDatasourceProvider);
  final localDatasource = ref.watch(movieWatchProvidersLocalDatasourceProvider);

  return MovieWatchProvidersRepositoryImpl(
    remoteDatasource: remoteDatasource,
    localDatasource: localDatasource,
  );
});
