import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';

abstract class MovieWatchProvidersDatasource {
  Future<Map<WatchProviderType, List<WatchProvider>>> fetchWatchProviders({
    required int movieId,
    required String locale,
    required String region,
  });

  Future<List<WatchProviderRegion>> fetchWatchProviderRegions({
    required String locale,
  });
}

class MovieWatchProvidersDatasourceImpl
    implements MovieWatchProvidersDatasource {
  final http.Client _httpClient;
  final String _apiKey;

  MovieWatchProvidersDatasourceImpl({
    required http.Client httpClient,
    required String apiKey,
  }) : _httpClient = httpClient,
       _apiKey = apiKey;

  String _buildLogoUrl(String path) {
    return 'https://image.tmdb.org/t/p/w92$path';
  }

  @override
  Future<Map<WatchProviderType, List<WatchProvider>>> fetchWatchProviders({
    required int movieId,
    required String locale,
    required String region,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/watch/providers?api_key=$_apiKey&language=$locale&watch_region=$region',
    );

    final response = await _httpClient.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final results = data['results'] as Map<String, dynamic>? ?? {};

      final countryData = results[region] as Map<String, dynamic>? ?? {};

      final Map<WatchProviderType, List<WatchProvider>> providers = {};

      void parseProviders(String key, WatchProviderType type) {
        if (countryData.containsKey(key)) {
          final list = (countryData[key] as List)
              .map(
                (e) => WatchProvider(
                  id: e['provider_id'] as int,
                  name: e['provider_name'] as String,
                  logoPath: e['logo_path'] != null
                      ? _buildLogoUrl(e['logo_path'] as String)
                      : null,
                ),
              )
              .toList();
          providers[type] = list;
        }
      }

      parseProviders('flatrate', WatchProviderType.flatrate);
      parseProviders('rent', WatchProviderType.rent);
      parseProviders('buy', WatchProviderType.buy);
      parseProviders('ads', WatchProviderType.ads);
      parseProviders('free', WatchProviderType.free);

      return providers;
    } else {
      throw Exception('Failed to fetch watch providers');
    }
  }

  @override
  Future<List<WatchProviderRegion>> fetchWatchProviderRegions({
    required String locale,
  }) async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/watch/providers/regions?api_key=$_apiKey&language=$locale',
    );

    final response = await _httpClient.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>? ?? [];

      return results
          .map(
            (e) => WatchProviderRegion(
              iso31661: e['iso_3166_1'] as String,
              nativeName: e['native_name'] as String,
            ),
          )
          .toList();
    } else {
      throw Exception('Failed to fetch watch provider regions');
    }
  }
}
