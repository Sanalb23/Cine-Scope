import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/movie_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/similar_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/favorite_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_details_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_overview.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_popularity.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_rating.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/trailer_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/watch_list_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_tag.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_poster.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_runtime.dart';
import 'package:cine_scope/features/movies/presentation/utils/no_image_avaliable.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieProvider(id));

    final similarMovies = ref.watch(similarMoviesProvider(id));

    return Scaffold(
      body: PaginatedScrollHandler(
        fetchCallback: () =>
            ref.read(similarMoviesProvider(id).notifier).fetchMore(),
        retryCallback: () =>
            ref.read(similarMoviesProvider(id).notifier).retry(),
        state: similarMovies,
        builder: (context, isFetchingMore, hasError) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                leading: Center(
                  child: AppBarButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actionsPadding: const EdgeInsets.only(right: AppSpacing.md),
                actions: [
                  movie.when(
                    data: (movie) =>
                        FavoriteButton(movieId: id, movieTitle: movie.title),
                    loading: () => const Padding(
                      padding: EdgeInsets.only(right: AppSpacing.md),
                      child: SkeletonPlaceholder(
                        height: 40,
                        width: 40,
                        isCircle: true,
                      ),
                    ),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  movie.when(
                    data: (movie) =>
                        WatchListButton(movieId: id, movieTitle: movie.title),
                    loading: () => const Padding(
                      padding: EdgeInsets.only(right: AppSpacing.md),
                      child: SkeletonPlaceholder(
                        height: 40,
                        width: 40,
                        isCircle: true,
                      ),
                    ),
                    error: (_, _) => const SizedBox.shrink(),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      movie.when(
                        data: (data) => data.backdropPath != null
                            ? CachedNetworkImage(
                                imageUrl: data.backdropPath!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const SkeletonPlaceholder(),
                                errorWidget: (context, url, error) =>
                                    const _BackdropErrorWidget(),
                              )
                            : const _BackdropErrorWidget(),
                        loading: () => const SkeletonPlaceholder(),
                        error: (_, _) => const _BackdropErrorWidget(),
                      ),
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
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: movie.when(
                  loading: () => const MovieDetailsSkeleton(),
                  error: (error, stackTrace) => SliverToBoxAdapter(
                    child: Center(
                      child: TryAgainLater(
                        onPressed: () => ref.invalidate(movieProvider(id)),
                      ),
                    ),
                  ),
                  data: (data) => SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: AppSpacing.xxl,
                      children: [
                        Row(
                          crossAxisAlignment: .start,
                          spacing: AppSpacing.xl,
                          children: [
                            SizedBox(
                              width: 135,
                              height: 200,
                              child: MoviePoster(posterPath: data.posterPath),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: .start,
                                spacing: AppSpacing.md,
                                children: [
                                  Text(
                                    data.title,
                                    style: context.textTheme.headlineMedium,
                                  ),
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
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: TrailerButton(trailerPath: data.trailerPath),
                        ),
                        MovieOverview(overview: data.overview),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                sliver: SliverToBoxAdapter(
                  child: Column(
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
                ),
              ),
            ],
          );
        },
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
