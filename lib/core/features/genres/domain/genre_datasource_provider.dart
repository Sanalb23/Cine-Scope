import 'package:cine_scope/core/features/genres/data/genres_remote_datasource.dart';
import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genreDatasourceProvider = Provider.autoDispose<GenresRemoteDataSource>((
  ref,
) {
  final httpClient = ref.watch(httpClientProvider);
  final apiKey = dotenv.env['TMDB_API_KEY']!;
  final language = ref.watch(localeProvider);

  return GenresRemoteDataSource(
    httpClient: httpClient,
    apiKey: apiKey,
    language: language.toLanguageTag(),
  );
});
