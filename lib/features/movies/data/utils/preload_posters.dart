import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<void> preloadPosters(List<MovieSummary> movies) async {
  await Future.wait(
    movies.map((movie) async {
      if (movie.posterPath == null) return;
      try {
        await DefaultCacheManager().downloadFile(movie.posterPath!);
      } catch (_) {
        // ignore
      }
    }),
  );
}
