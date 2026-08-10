import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/watch_list_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListBody extends ConsumerWidget {
  const WatchListBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(watchListMoviesProvider);

    return PaginatedMoviesList(
      fetchCallback: () =>
          ref.read(watchListMoviesProvider.notifier).fetchMore(),
      retryCallback: () => ref.read(watchListMoviesProvider.notifier).retry(),
      state: movies,
      title: 'watch_list'.tr(),
    );
  }
}
