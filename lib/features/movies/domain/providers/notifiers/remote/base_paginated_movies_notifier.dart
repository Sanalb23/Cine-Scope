import 'package:cine_scope/core/extensions/ref_extensions.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/data/utils/preload_posters.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/pagination/paginated_notifier.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';

abstract class BasePaginatedMoviesNotifier
    extends PaginatedNotifier<MovieSummary> {
  /// Optional cache duration - override to customize caching behavior
  Duration get cacheDuration => const Duration(minutes: 3);

  @override
  PaginatedState<MovieSummary> build() {
    ref.watch(localeProvider);
    ref.cache(cacheDuration);
    return super.build();
  }

  @override
  Future<void> preloadFn(List<MovieSummary> items) async {
    await preloadPosters(items);
  }
}
