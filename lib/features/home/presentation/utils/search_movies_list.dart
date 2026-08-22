import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_custom_scroll_view.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMoviesList extends ConsumerWidget {
  const SearchMoviesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchMoviesProvider(query));

    return PaginatedCustomScrollView(
      fetchCallback: () =>
          ref.read(searchMoviesProvider(query).notifier).fetchMore(),
      slivers: [
        SliverAppBar(
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          backgroundColor: context.theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          floating: true,
          snap: true,
          toolbarHeight: 88,
          title: const MovieSearchBar(),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            bottom: AppSpacing.xl,
            right: AppSpacing.lg,
            left: AppSpacing.lg,
          ),
          sliver: SliverToBoxAdapter(
            child: MoviesList(
              state: query.isEmpty ? PaginatedState(items: []) : results,
              emptyText: query.isEmpty
                  ? 'search_for_a_movie'.tr()
                  : 'no_movies_found'.tr(),
              retryCallback: () =>
                  ref.read(searchMoviesProvider(query).notifier).retry(),
            ),
          ),
        ),
      ],
    );
  }
}
