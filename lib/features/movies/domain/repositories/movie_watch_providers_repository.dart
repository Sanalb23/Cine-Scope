import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';

abstract class MovieWatchProvidersRepository {
  Future<Map<WatchProviderType, List<WatchProvider>>> getWatchProviders({
    required int movieId,
    required String locale,
    required String region,
  });

  Future<List<WatchProviderRegion>> getWatchProviderRegions({
    required String locale,
  });
}
