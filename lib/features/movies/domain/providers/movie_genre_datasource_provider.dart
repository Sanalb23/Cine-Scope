import 'package:cine_scope/features/movies/data/datasource/movie_genre_remote_datasource.dart';
import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreDatasourceProvider = Provider<MovieGenreRemoteDataSource>((
  ref,
) {
  final httpClient = ref.watch(httpClientProvider);
  final apiKey = dotenv.env['TMDB_API_KEY']!;
  final language = ref.watch(localeProvider);

  return MovieGenreRemoteDataSource(
    httpClient: httpClient,
    apiKey: apiKey,
    language: language.toLanguageTag(),
  );
});
