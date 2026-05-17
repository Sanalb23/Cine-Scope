import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/skeleton_placeholder.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';

class MovieDetailsSkeleton extends StatelessWidget {
  const MovieDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
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
          actions: const [
            Padding(
              padding: EdgeInsets.all(4.0),
              child: SkeletonPlaceholder(width: 40, height: 40, isCircle: true),
            ),
            SizedBox(width: AppSpacing.md),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: SkeletonPlaceholder(width: 40, height: 40, isCircle: true),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(background: SkeletonPlaceholder()),
        ),
        SliverPadding(
          padding: EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.md,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSpacing.xl,
                  children: [
                    // Poster
                    const SkeletonPlaceholder(width: 135, height: 200),

                    Expanded(
                      child: Column(
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
                              (index) => const SkeletonPlaceholder(
                                width: 70,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Trailer button
                const SkeletonPlaceholder(height: 50, width: double.infinity),

                const SizedBox(height: AppSpacing.xl),

                // overview
                const SkeletonPlaceholder(height: 28, width: 150),
                const SizedBox(height: AppSpacing.sm),
                ...List.generate(
                  4,
                  (index) => SkeletonPlaceholder(
                    height: 16,
                    width: index == 3 ? 200 : double.infinity,
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Similar movies title
                const SkeletonPlaceholder(height: 28, width: 150),
                const SizedBox(height: AppSpacing.sm),

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
