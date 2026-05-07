import 'package:cine_scope/features/movies/data/utils/preload_posters.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/pagination/paginated_notifier.dart';

abstract class BasePaginatedMoviesNotifier
    extends PaginatedNotifier<MovieSummary> {
  @override
  Future<void> preloadFn(List<MovieSummary> items) async {
    await preloadPosters(items);
  }
}
