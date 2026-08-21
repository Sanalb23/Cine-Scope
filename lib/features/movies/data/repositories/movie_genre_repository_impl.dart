import 'package:cine_scope/features/movies/data/datasource/movie_genre_local_datasource.dart';
import 'package:cine_scope/features/movies/data/datasource/movie_genre_remote_datasource.dart';
import 'package:cine_scope/features/movies/domain/repositories/movie_genre_repository.dart';

class MovieGenreRepositoryImpl implements MovieGenreRepository {
  final MovieGenreRemoteDataSource _remoteDataSource;
  final MovieGenreLocalDataSource _localDataSource;

  MovieGenreRepositoryImpl({
    required MovieGenreRemoteDataSource remoteDataSource,
    required MovieGenreLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Map<int, String>> getMovieGenres({required String language}) async {
    final cachedGenres = await _localDataSource.getCachedMovieGenres(language);
    
    if (cachedGenres != null && cachedGenres.isNotEmpty) {
      return cachedGenres;
    }

    final remoteGenres = await _remoteDataSource.getMovieGenres(language: language);
    await _localDataSource.cacheMovieGenres(language, remoteGenres);

    return remoteGenres;
  }
}
