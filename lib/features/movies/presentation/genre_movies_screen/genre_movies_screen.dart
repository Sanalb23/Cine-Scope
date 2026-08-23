import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/custom_sliver_app_bar.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/genre_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
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
      body: SafeArea(
        child: PaginatedCustomScrollView(
          fetchCallback: () =>
              ref.read(genreMoviesProvider(genreId).notifier).fetchMore(),
          slivers: [
            CustomSliverAppBar(
              leading: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: AppBarButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              titleText: genreName,
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
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
