import 'package:cine_scope/features/movies/data/datasource/movie_genre_remote_datasource.dart';
import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/api_key_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreRemoteDataSourceProvider = Provider<MovieGenreRemoteDataSource>((
  ref,
) {
  final httpClient = ref.watch(httpClientProvider);
  final apiKey = ref.watch(apiKeyProvider);

  return MovieGenreRemoteDataSource(
    httpClient: httpClient,
    apiKey: apiKey,
  );
});
