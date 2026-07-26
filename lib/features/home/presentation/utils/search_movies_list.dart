import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchMoviesList extends ConsumerWidget {
  const SearchMoviesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchMoviesProvider(query));

    return results.items.isEmpty
        ? Center(
            child: Text(
              query.isNotEmpty
                  ? 'no_movies_found'.tr()
                  : 'search_for_a_movie'.tr(),
            ),
          )
        : PaginatedMoviesList(
            fetchCallback: () =>
                ref.read(searchMoviesProvider(query).notifier).fetchMore(),
            retryCallback: () =>
                ref.read(searchMoviesProvider(query).notifier).retry(),
            state: results,
          );
  }
}
