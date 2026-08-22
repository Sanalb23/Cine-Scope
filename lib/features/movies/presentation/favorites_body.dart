import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/custom_sliver_app_bar.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/favorite_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_custom_scroll_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_filter_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/selected_genres_chips.dart';

class FavoritesBody extends ConsumerWidget {
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(favoriteMoviesProvider);

    return PaginatedCustomScrollView(
      fetchCallback: () =>
          ref.read(favoriteMoviesProvider.notifier).fetchMore(),
      slivers: [
        CustomSliverAppBar(
          titleText: 'favorites'.tr(),
          actions: const [GenreFilterButton()],
        ),
        const SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          sliver: SliverToBoxAdapter(child: SelectedGenresChips()),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            bottom: AppSpacing.xl,
            right: AppSpacing.lg,
            left: AppSpacing.lg,
          ),
          sliver: SliverToBoxAdapter(
            child: MoviesList(
              state: movies,
              retryCallback: () =>
                  ref.read(favoriteMoviesProvider.notifier).retry(),
            ),
          ),
        ),
      ],
    );
  }
}
