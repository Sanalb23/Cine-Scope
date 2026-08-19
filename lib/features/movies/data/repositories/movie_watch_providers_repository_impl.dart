import 'package:cine_scope/features/movies/data/datasource/movie_watch_providers_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_watch_providers_local_datasource.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_watch_providers_repository.dart';

class MovieWatchProvidersRepositoryImpl
    implements MovieWatchProvidersRepository {
  final MovieWatchProvidersRemoteDatasource _remoteDatasource;
  final MovieWatchProvidersLocalDatasource _localDatasource;

  MovieWatchProvidersRepositoryImpl({
    required MovieWatchProvidersRemoteDatasource remoteDatasource,
    required MovieWatchProvidersLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<Map<WatchProviderType, List<WatchProvider>>> getWatchProviders({
    required int movieId,
    required String locale,
    required String region,
  }) async {
    final modelsMap = await _remoteDatasource.fetchWatchProviders(
      movieId: movieId,
      locale: locale,
      region: region,
    );

    final Map<WatchProviderType, List<WatchProvider>> providers = {};

    modelsMap.forEach((type, list) {
      providers[type] = list.map((m) => m.toDomain()).toList();
    });

    return providers;
  }

  @override
  Future<List<WatchProviderRegion>> getWatchProviderRegions({
    required String locale,
  }) async {
    final cachedRegions = await _localDatasource.getCachedWatchProviderRegions(
      locale,
    );

    if (cachedRegions != null && cachedRegions.isNotEmpty) {
      return cachedRegions.map((m) => m.toDomain()).toList();
    }

    final remoteRegions = await _remoteDatasource.fetchWatchProviderRegions(
      locale: locale,
    );

    await _localDatasource.cacheWatchProviderRegions(locale, remoteRegions);

    return remoteRegions.map((m) => m.toDomain()).toList();
  }
}
