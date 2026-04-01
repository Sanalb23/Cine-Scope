import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie.dart';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppSpacing.md,
                children: [
                  Text(
                    mockMovie.title,
                    style: context.textTheme.headlineMedium,
                  ),
                  Row(
                    spacing: AppSpacing.xxl,
                    children: [
                      _MovieRating(voteAverage: mockMovie.voteAverage),
                      _InfoRowSpacer(),
                      Text(mockMovie.releaseDate.substring(0, 4)),
                      _InfoRowSpacer(),
                      Text(mockMovie.originalLanguage.toUpperCase()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieRating extends StatelessWidget {
  const _MovieRating({required this.voteAverage});

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: AppSpacing.sm),
        Text(
          voteAverage.toStringAsFixed(1),
          style: context.textTheme.bodyMedium,
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
