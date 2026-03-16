import 'package:cine_scope/features/movies/data/datasource/movie_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/tmdb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDatasourceProvider = Provider.autoDispose<MovieDatasource>(
  (ref) => TmdbDatasource(),
);
