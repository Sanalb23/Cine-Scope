import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/favorite_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMoviesScreen extends ConsumerWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(favoriteMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites', style: context.textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: MoviesList(
          movies: movies,
          onFetchMore: () =>
              ref.read(favoriteMoviesProvider.notifier).fetchMore(),
          onRefresh: () async => ref.refresh(favoriteMoviesProvider),
        ),
      ),
    );
  }
}
