import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieSearchBar extends ConsumerWidget {
  const MovieSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SearchBar(
      trailing: [const Icon(Icons.search)],
      hintText: 'search_ellipsis'.tr(),
      onChanged: (value) {
        ref.read(searchQueryProvider.notifier).setSearchQuery(value);
      },
    );
  }
}
