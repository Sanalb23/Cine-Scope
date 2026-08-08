import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/movie_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/similar_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/countdown_banner.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/favorite_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_details_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_overview.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_popularity.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_rating.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/trailer_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/watch_list_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/days_until_release_date.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_tag.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_poster.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_release_date.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_runtime.dart';
import 'package:cine_scope/features/movies/presentation/utils/no_image_avaliable.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieProvider(id));

    final similarMovies = ref.watch(similarMoviesProvider(id));

    final isLandscape = context.isLandscape;

    return Scaffold(
      body: SafeArea(
        child: movie.when(
          data: (data) {
            final daysUntilRelease = daysUntilReleaseDate(data.releaseDate);

            final overviewWidget = MovieOverview(overview: data.overview);

            final trailerButtonWidget = SizedBox(
              width: double.infinity,
              height: 44,
              child: TrailerButton(trailerPath: data.trailerPath),
            );

            final countdownWidget = !kIsWeb && daysUntilRelease != null
                ? CountDownBanner(
                    movieId: id,
                    movieTitle: data.title,
                    releaseDate: data.releaseDate,
                    daysUntilRelease: daysUntilRelease,
                  )
                : null;

            final movieTitle = data.title;

            final primaryInfoColumn = Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.md,
              children: [
                Text(movieTitle, style: context.textTheme.headlineMedium),
                MovieReleaseDate(releaseDate: data.releaseDate),
                MovieRuntime(runtime: data.runtime),
                MoviePopularity(popularity: data.popularity),
                MovieRating(
                  voteAverage: data.voteAverage,
                  voteCount: data.voteCount,
                ),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: data.genres
                      .map((e) => GenreTag(genre: e.name))
                      .toList(),
                ),

                if (isLandscape) ...[
                  overviewWidget,
                  countdownWidget != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: countdownWidget,
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: trailerButtonWidget,
                  ),
                ],
              ],
            );

            final moviePoster = InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 2 / 3,
                            child: MoviePoster(posterPath: data.posterPath),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton.filled(
                                style: IconButton.styleFrom(
                                  backgroundColor: context.colors.surface
                                      .withValues(alpha: 0.5),
                                  foregroundColor: context.colors.onSurface,
                                ),
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              child: SizedBox(
                width: context.screenDiagonal * 0.15,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: MoviePoster(posterPath: data.posterPath),
                ),
              ),
            );

            return PaginatedScrollHandler(
              fetchCallback: () =>
                  ref.read(similarMoviesProvider(id).notifier).fetchMore(),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: context.screenDiagonal * 0.175,
                    pinned: true,
                    leading: Center(
                      child: AppBarButton(
                        icon: Icons.arrow_back,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    actionsPadding: const EdgeInsets.only(right: AppSpacing.md),
                    actions: [
                      FavoriteButton(movieId: id, movieTitle: data.title),
                      const SizedBox(width: AppSpacing.md),
                      WatchListButton(movieId: id, movieTitle: data.title),
                    ],
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        double topPadding = MediaQuery.of(context).padding.top;

                        final isCollapsed =
                            constraints.maxHeight <=
                            kToolbarHeight + topPadding;

                        return FlexibleSpaceBar(
                          title: isCollapsed ? Text(movieTitle) : null,
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              data.backdropPath != null
                                  ? CachedNetworkImage(
                                      imageUrl: data.backdropPath!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SkeletonPlaceholder(),
                                      errorWidget: (context, url, error) =>
                                          const _BackdropErrorWidget(),
                                    )
                                  : const _BackdropErrorWidget(),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      context.theme.scaffoldBackgroundColor,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: .start,
                        spacing: AppSpacing.xxl,
                        children: [
                          Row(
                            crossAxisAlignment: .start,
                            spacing: AppSpacing.xl,
                            children: [
                              moviePoster,

                              if (context.screenWidth >= 1200) ...[
                                SizedBox(
                                  width: context.screenWidth * 0.3,
                                  child: primaryInfoColumn,
                                ),
                              ] else ...[
                                Expanded(child: primaryInfoColumn),
                              ],
                            ],
                          ),

                          if (!isLandscape) ...[
                            countdownWidget ?? SizedBox.shrink(),
                            trailerButtonWidget,
                            overviewWidget,
                          ],

                          const Divider(),
                          Column(
                            crossAxisAlignment: .start,
                            spacing: AppSpacing.lg,
                            children: [
                              Text(
                                'Similar Movies',
                                style: context.textTheme.headlineSmall,
                              ),
                              PaginatedMoviesList(
                                fetchCallback: () => ref
                                    .read(similarMoviesProvider(id).notifier)
                                    .fetchMore(),
                                retryCallback: () => ref
                                    .read(similarMoviesProvider(id).notifier)
                                    .retry(),
                                state: similarMovies,
                                isScrollable: false,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const MovieDetailsSkeleton(),
          error: (error, stackTrace) => Center(
            child: TryAgainLater(
              onPressed: () => ref.invalidate(movieProvider(id)),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackdropErrorWidget extends StatelessWidget {
  const _BackdropErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surfaceContainerHighest,
      child: const Center(child: NoImageAvaliable()),
    );
  }
}
