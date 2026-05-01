import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRemoteDatasourceProvider =
    Provider.autoDispose<MovieRemoteDatasource>((ref) {
      final httpClient = ref.watch(httpClientProvider);
      final apiKey = dotenv.env['TMDB_API_KEY']!;
      final locale = ref.watch(localeProvider);
      return MovieRemoteDatasourceImpl(
        httpClient: httpClient, 
        apiKey: apiKey,
        language: locale.toLanguageTag(),
      );
    });
