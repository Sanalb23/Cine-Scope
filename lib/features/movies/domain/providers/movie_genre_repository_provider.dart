import 'package:cine_scope/features/movies/data/repositories/movie_genre_repository_impl.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_local_datasource_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_genre_remote_datasource_provider.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_genre_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieGenreRepositoryProvider = Provider<MovieGenreRepository>((ref) {
  final remoteDataSource = ref.watch(movieGenreRemoteDataSourceProvider);
  final localDataSource = ref.watch(movieGenreLocalDataSourceProvider);

  return MovieGenreRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});
