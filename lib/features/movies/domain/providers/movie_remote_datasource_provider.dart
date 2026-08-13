import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource_impl.dart';
import 'package:cine_scope/core/providers/api_key_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRemoteDatasourceProvider =
    Provider.autoDispose<MovieRemoteDatasource>((ref) {
      final httpClient = ref.watch(httpClientProvider);
      final apiKey = ref.watch(apiKeyProvider);
      final locale = ref.watch(localeProvider);
      return MovieRemoteDatasourceImpl(
        httpClient: httpClient, 
        apiKey: apiKey,
        language: locale.toLanguageTag(),
      );
    });
