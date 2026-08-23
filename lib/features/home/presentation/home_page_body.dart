import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/custom_sliver_app_bar.dart';
import 'package:cine_scope/features/movies/domain/providers/movies_by_category_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_custom_scroll_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_filter_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/selected_genres_chips.dart';

class HomePageBody extends ConsumerWidget {
  const HomePageBody({super.key});

  PopupMenuItem<MovieListCategory> _buildPopupMenuItem(
    MovieListCategory category,
  ) {
    return PopupMenuItem(
      value: category,
      child: Row(
        spacing: AppSpacing.sm,
        children: [Icon(category.icon), Text(category.title)],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listState = ref.watch(moviesByCategoryProvider);

    final popupMenuButton = PopupMenuButton<MovieListCategory>(
      tooltip: 'explore_movies'.tr(),
      icon: const Icon(Icons.filter_list),
      itemBuilder: (context) {
        return [
          _buildPopupMenuItem(MovieListCategory.popular),
          _buildPopupMenuItem(MovieListCategory.topRated),
          _buildPopupMenuItem(MovieListCategory.upcoming),
        ];
      },
      onSelected: (value) {
        ref.read(moviesByCategoryProvider.notifier).switchCategory(value);
      },
    );

    return PaginatedCustomScrollView(
      fetchCallback: listState.fetchCallback,
      slivers: [
        CustomSliverAppBar(
          titleText: listState.category.title,
          actions: [
            const GenreFilterButton(),
            const SizedBox(width: AppSpacing.md),
            popupMenuButton,
          ],
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
              state: listState.state,
              retryCallback: listState.retryCallback,
            ),
          ),
        ),
      ],
    );
  }
}
