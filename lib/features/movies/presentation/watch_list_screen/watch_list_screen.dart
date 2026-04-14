import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/watch_list_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListScreen extends ConsumerWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(watchListMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Watch List', style: context.textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: MoviesList(
          movies: movies,
          onFetchMore: () =>
              ref.read(watchListMoviesProvider.notifier).fetchMore(),
          onRefresh: () async => ref.refresh(watchListMoviesProvider),
        ),
      ),
    );
  }
}
