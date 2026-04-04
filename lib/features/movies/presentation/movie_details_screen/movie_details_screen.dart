import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/favorite_button.dart';
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

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final mockMovie = Movie(
      id: id,
      title: 'Fight Club',
      overview:
          'A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground "fight clubs" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.',
      posterPath:
          'https://image.tmdb.org/t/p/w500/pB8BM7pSp6B6Ih7QZ4DrQ3PmJK.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w500/hZkgoQYusvegHoetLkCJzb17zJ.jpg',
      voteAverage: 8.433,
      voteCount: 26280,
      releaseDate: '1999-10-15',
      genres: [(18, 'Drama'), (53, 'Thriller'), (35, 'Comedy')],
      originalLanguage: 'en',
      adult: false,
      popularity: 61.416,
    );

    return Scaffold(
      body: CustomScrollView(
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
                    imageUrl: mockMovie.backdropPath,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SkeletonPlaceholder(),
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
                        child: MoviePoster(posterPath: mockMovie.posterPath),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,

                          spacing: AppSpacing.md,

                          children: [
                            Text(
                              mockMovie.title,
                              style: context.textTheme.headlineMedium,
                            ),

                            MoviePopularity(popularity: mockMovie.popularity),

                            MovieRating(
                              voteAverage: mockMovie.voteAverage,
                              voteCount: mockMovie.voteCount,
                            ),

                            MovieQuickInfo(
                              releaseDate: mockMovie.releaseDate,
                              originalLanguage: mockMovie.originalLanguage,
                              adult: mockMovie.adult,
                            ),

                            Wrap(
                              spacing: AppSpacing.md,
                              runSpacing: AppSpacing.md,
                              children: mockMovie.genres
                                  .map((e) => GenreTag(genre: e.$2))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  MovieOverview(overview: mockMovie.overview),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
