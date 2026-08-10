import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';

class MovieDetailsSkeleton extends StatelessWidget {
  const MovieDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    final trailerButtonWidget = const SkeletonPlaceholder(
      height: 50,
      width: double.infinity,
    );

    final overviewWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        const SkeletonPlaceholder(height: 28, width: 150),
        ...List.generate(
          4,
          (index) => SkeletonPlaceholder(
            height: 16,
            width: index == 3 ? 200 : double.infinity,
          ),
        ),
      ],
    );

    final primaryInfoColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.md,
      children: [
        // Title
        const SkeletonPlaceholder(width: 220, height: 32),

        // Runtime
        const SkeletonPlaceholder(width: 80, height: 18),

        // Popularity
        const SkeletonPlaceholder(width: 160, height: 30),

        // Rating
        const SkeletonPlaceholder(width: 80, height: 20),

        // Quick info
        const SkeletonPlaceholder(width: 120, height: 20),

        // Genres
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: List.generate(
            3,
            (index) => const SkeletonPlaceholder(width: 70, height: 20),
          ),
        ),

        if (isLandscape) ...[
          overviewWidget,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: trailerButtonWidget,
          ),
        ],
      ],
    );

    return CustomScrollView(
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SkeletonPlaceholder(
                width: isLandscape ? 180 : 40,
                height: 40,
                isCircle: !isLandscape,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SkeletonPlaceholder(
                width: isLandscape ? 180 : 40,
                height: 40,
                isCircle: !isLandscape,
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(background: SkeletonPlaceholder()),
        ),
        SliverPadding(
          padding: EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.xxl,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xl,
                  children: [
                    // Poster
                    SizedBox(
                      width: context.screenDiagonal * 0.15,
                      child: const AspectRatio(
                        aspectRatio: 2 / 3,
                        child: SkeletonPlaceholder(),
                      ),
                    ),

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

                if (!isLandscape) ...[trailerButtonWidget, overviewWidget],

                // Similar movies title
                const SkeletonPlaceholder(height: 28, width: 150),

                // Similar movies grid skeleton
                const MovieListSkeleton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
