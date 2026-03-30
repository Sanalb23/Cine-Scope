import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<List<MovieSummary>> preloadPosters(List<MovieSummary> movies) async {
  await Future.wait(
    movies.map((movie) async {
      try {
        await DefaultCacheManager().downloadFile(movie.posterPath);
      } catch (e) {
        // ignore
      }
    }),
  );
  return movies;
}
