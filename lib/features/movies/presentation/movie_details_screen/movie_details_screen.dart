import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
import 'package:cine_scope/features/movies/presentation/genre_tags_row.dart';
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
          'https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
      backdropPath:
          'https://image.tmdb.org/t/p/w500/hZkgoQYus5vegHoetLkCJzb17zJ.jpg',
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
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(mockMovie.backdropPath, fit: BoxFit.cover),
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
                      _MoviePoster(posterPath: mockMovie.posterPath),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,

                          spacing: AppSpacing.md,

                          children: [
                            Text(
                              mockMovie.title,
                              style: context.textTheme.headlineMedium,
                            ),

                            _MoviePopularity(popularity: mockMovie.popularity),

                            _MovieRating(
                              voteAverage: mockMovie.voteAverage,
                              voteCount: mockMovie.voteCount,
                            ),

                            _MovieQuickInfo(
                              releaseDate: mockMovie.releaseDate,
                              originalLanguage: mockMovie.originalLanguage,
                              adult: mockMovie.adult,
                            ),

                            GenreTagsRow(
                              genreIds: mockMovie.genres
                                  .map((e) => e.$1)
                                  .toList(),
                              spacing: AppSpacing.md,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),
                  _MovieOverview(overview: mockMovie.overview),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieQuickInfo extends StatelessWidget {
  const _MovieQuickInfo({
    required this.releaseDate,
    required this.originalLanguage,
    required this.adult,
  });

  final String releaseDate;
  final String originalLanguage;
  final bool adult;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSpacing.xl,
      runSpacing: AppSpacing.md,
      children: [
        Text(releaseDate.substring(0, 4)),
        const _InfoRowSpacer(),
        Text(originalLanguage.toUpperCase()),
        if (adult) ...[
          const _InfoRowSpacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm / 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: context.colors.error),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '18+',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colors.error,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({required this.voteAverage, required this.voteCount});

  final double voteAverage;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    final formattedVoteCount = switch (voteCount) {
      < 10000 => voteCount.toString(),
      < 1000000 => '${(voteCount / 1000).truncate()}K',
      < 1000000000 => '${(voteCount / 1000000).truncate()}M',
      _ => voteCount.toString(),
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        Icon(Icons.star, color: Colors.amber),
        Text(
          voteAverage.toStringAsFixed(1),
          style: context.textTheme.bodyLarge,
        ),
        Text(
          '(${formattedVoteCount} votes)',
          style: context.textTheme.labelSmall,
        ),
      ],
    );
  }
}

class _InfoRowSpacer extends StatelessWidget {
  const _InfoRowSpacer();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      size: 8,
      color: context.colors.onSurface.withValues(alpha: 0.5),
    );
  }
}

class _MovieOverview extends StatelessWidget {
  const _MovieOverview({required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        Text('Overview', style: context.textTheme.headlineSmall),
        Text(overview, style: context.textTheme.bodyMedium),
      ],
    );
  }
}

class _MoviePopularity extends StatelessWidget {
  const _MoviePopularity({required this.popularity});

  final double popularity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.error.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: .min,
        spacing: AppSpacing.sm,
        children: [
          Icon(
            Icons.local_fire_department_outlined,
            size: 16,
            color: context.colors.error,
          ),
          Text(
            'POPULARITY: ${popularity.toStringAsFixed(1)}',
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({required this.posterPath});

  final String posterPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          posterPath,
          width: 135,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
