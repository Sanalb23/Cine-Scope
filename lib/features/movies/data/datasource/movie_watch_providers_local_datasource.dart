import 'dart:convert';
import 'package:cine_scope/features/movies/data/models/watch_provider_region_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MovieWatchProvidersLocalDatasource {
  Future<List<WatchProviderRegionModel>?> getCachedWatchProviderRegions(
    String locale,
  );

  Future<void> cacheWatchProviderRegions(
    String locale,
    List<WatchProviderRegionModel> regions,
  );
}

class MovieWatchProvidersLocalDatasourceImpl
    implements MovieWatchProvidersLocalDatasource {
  final SharedPreferences _prefs;

  MovieWatchProvidersLocalDatasourceImpl({required SharedPreferences prefs})
    : _prefs = prefs;

  String _getCacheKey(String locale) => 'watch_provider_regions_$locale';

  @override
  Future<List<WatchProviderRegionModel>?> getCachedWatchProviderRegions(
    String locale,
  ) async {
    final key = _getCacheKey(locale);
    final jsonString = _prefs.getString(key);

    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList
            .map((e) => WatchProviderRegionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> cacheWatchProviderRegions(
    String locale,
    List<WatchProviderRegionModel> regions,
  ) async {
    final key = _getCacheKey(locale);
    final jsonList = regions.map((e) => e.toJson()).toList();
    await _prefs.setString(key, jsonEncode(jsonList));
  }
}
