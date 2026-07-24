import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum.dart';
import 'package:cine_scope/features/movies/data/enum/movie_list_category_enum_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/movies_by_category_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return Column(
      spacing: AppSpacing.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              listState.category.title,
              style: context.textTheme.headlineSmall,
            ),
            const Spacer(),
            PopupMenuButton<MovieListCategory>(
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
                ref
                    .read(moviesByCategoryProvider.notifier)
                    .switchCategory(value);
              },
            ),
          ],
        ),
        Expanded(
          child: PaginatedMoviesList(
            fetchCallback: listState.fetchCallback,
            retryCallback: listState.retryCallback,
            state: listState.state,
          ),
        ),
      ],
    );
  }
}
