import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/genre_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_custom_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreMoviesScreen extends ConsumerWidget {
  const GenreMoviesScreen({
    super.key,
    required this.genreId,
    required this.genreName,
  });

  final int genreId;
  final String genreName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(genreMoviesProvider(genreId));

    return Scaffold(
      appBar: AppBar(title: Text(genreName), centerTitle: true),
      body: SafeArea(
        child: PaginatedCustomScrollView(
          fetchCallback: () =>
              ref.read(genreMoviesProvider(genreId).notifier).fetchMore(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom: AppSpacing.xl,
              ),
              sliver: SliverToBoxAdapter(
                child: MoviesList(
                  state: state,
                  retryCallback: () =>
                      ref.read(genreMoviesProvider(genreId).notifier).retry(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
