import 'package:cine_scope/core/providers/http_client_provider.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_remote_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/tmdb_datasource.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRemoteDatasourceProvider =
    Provider.autoDispose<MovieRemoteDatasource>((ref) {
      final httpClient = ref.watch(httpClientProvider);
      final apiKey = dotenv.env['TMDB_API_KEY']!;
      return TmdbDatasource(httpClient: httpClient, apiKey: apiKey);
    });
