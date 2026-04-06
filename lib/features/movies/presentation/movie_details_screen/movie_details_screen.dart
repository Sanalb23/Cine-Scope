import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/core/widgets/try_again_later.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/movie_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/favorite_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_details_skeleton.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_overview.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_popularity.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_quick_info.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_rating.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/watch_list_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/genre_tag.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_poster.dart';
import 'package:cine_scope/features/movies/presentation/utils/no_image_avaliable.dart';
import 'package:cine_scope/features/movies/presentation/utils/skeleton_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(movieProvider(id));

    return Scaffold(
      body: movie.when(
        skipLoadingOnRefresh: false,
        data: (data) {
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
                  FavoriteButton(movieId: id),
                  const SizedBox(width: AppSpacing.md),
                  WatchListButton(movieId: id),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: data.backdropPath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const SkeletonPlaceholder(),
                        errorWidget: (context, url, error) => Container(
                          color: context.colors.surfaceContainerHighest,
                          child: const Center(child: NoImageAvaliable()),
                        ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.md,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.md,
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

                                MoviePopularity(popularity: data.popularity),

                                MovieRating(
                                  voteAverage: data.voteAverage,
                                  voteCount: data.voteCount,
                                ),

                                MovieQuickInfo(
                                  releaseDate: data.releaseDate,
                                  originalLanguage: data.originalLanguage,
                                  adult: data.adult,
                                ),

                                Wrap(
                                  spacing: AppSpacing.md,
                                  runSpacing: AppSpacing.md,
                                  children: data.genres
                                      .map((e) => GenreTag(genre: e.$2))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xl),
                      MovieOverview(overview: data.overview),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: TryAgainLater(
              onPressed: () => ref.invalidate(movieProvider(id)),
            ),
          );
        },
        loading: () {
          return const MovieDetailsSkeleton();
        },
      ),
    );
  }
}
