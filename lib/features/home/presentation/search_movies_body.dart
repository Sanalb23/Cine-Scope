import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/home/presentation/utils/search_movies_list.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/pagination/utils/paginated_custom_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMoviesBody extends ConsumerWidget {
  const SearchMoviesBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

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
        const SliverPadding(
          padding: EdgeInsets.only(
            bottom: AppSpacing.xl,
            right: AppSpacing.lg,
            left: AppSpacing.lg,
          ),
          sliver: SliverToBoxAdapter(
            child: SearchMoviesList(),
          ),
        ),
      ],
    );
  }
}
