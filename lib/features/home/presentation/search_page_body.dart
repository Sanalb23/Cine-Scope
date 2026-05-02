import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/paginated_scroll_handler.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPageBody extends ConsumerStatefulWidget {
  const SearchPageBody({super.key});

  @override
  ConsumerState<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends ConsumerState<SearchPageBody> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.lg,
      children: [
        SearchBar(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          ),
          controller: _searchController,
          trailing: [const Icon(Icons.search)],
          hintText: 'search_ellipsis'.tr(),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).setSearchQuery(value);
          },
        ),

        const Expanded(child: _MoviesList()),
      ],
    );
  }
}

class _MoviesList extends ConsumerWidget {
  const _MoviesList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);

    final results = ref.watch(searchMoviesProvider(query));

    return query.isEmpty
        ? Center(child: Text('search_for_a_movie'.tr()))
        : PaginatedScrollHandler(
            onFetchMore: () =>
                ref.read(searchMoviesProvider(query).notifier).fetchMore(),
            builder: (context, isFetchingMore) {
              return ListView(
                shrinkWrap: true,
                children: [
                  MoviesList(
                    movies: results,
                    onRetry: () => ref.invalidate(searchMoviesProvider(query)),
                  ),
                  if (isFetchingMore) const MovieListSkeleton(),
                ],
              );
            },
          );
  }
}
