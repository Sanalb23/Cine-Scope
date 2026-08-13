import 'package:cine_scope/features/movies/data/datasource/movie_genre_remote_datasource.dart';
import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/core/providers/api_key_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreDatasourceProvider = Provider<MovieGenreRemoteDataSource>((
  ref,
) {
  final httpClient = ref.watch(httpClientProvider);
  final apiKey = ref.watch(apiKeyProvider);
  final language = ref.watch(localeProvider);

  return MovieGenreRemoteDataSource(
    httpClient: httpClient,
    apiKey: apiKey,
    language: language.toLanguageTag(),
  );
});
