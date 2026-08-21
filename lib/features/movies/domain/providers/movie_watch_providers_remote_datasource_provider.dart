import 'package:cine_scope/core/providers/api_key_provider.dart';
import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_watch_providers_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieWatchProvidersRemoteDatasourceProvider =
    Provider<MovieWatchProvidersRemoteDatasource>((ref) {
      final httpClient = ref.watch(httpClientProvider);
      final apiKey = ref.watch(apiKeyProvider);

      return MovieWatchProvidersRemoteDatasourceImpl(
        httpClient: httpClient,
        apiKey: apiKey,
      );
    });
