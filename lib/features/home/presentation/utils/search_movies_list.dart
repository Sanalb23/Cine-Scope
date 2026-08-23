import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_movies_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
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

    return MoviesList(
      state: query.isEmpty ? PaginatedState(items: []) : results,
      emptyText: query.isEmpty
          ? 'search_for_a_movie'.tr()
          : 'no_movies_found'.tr(),
      retryCallback: () =>
          ref.read(searchMoviesProvider(query).notifier).retry(),
    );
  }
}

