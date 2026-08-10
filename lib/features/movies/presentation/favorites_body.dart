import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/favorite_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesBody extends ConsumerWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(favoriteMoviesProvider);

    return PaginatedMoviesList(
      fetchCallback: () =>
          ref.read(favoriteMoviesProvider.notifier).fetchMore(),
      retryCallback: () => ref.read(favoriteMoviesProvider.notifier).retry(),
      state: movies,
      title: 'favorites'.tr(),
    );
  }
}
