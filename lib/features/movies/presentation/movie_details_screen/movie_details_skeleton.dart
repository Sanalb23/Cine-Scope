import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/presentation/utils/skeleton_placeholder.dart';
import 'package:flutter/material.dart';

class MovieDetailsSkeleton extends StatelessWidget {
  const MovieDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            leading: Center(
              child: BackButton(onPressed: () => Navigator.pop(context)),
            ),
            actionsPadding: const EdgeInsets.only(right: AppSpacing.md),
            actions: const [
              SizedBox(width: 40, height: 40, child: SkeletonPlaceholder()),
              SizedBox(width: AppSpacing.md),
              SizedBox(width: 40, height: 40, child: SkeletonPlaceholder()),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const SkeletonPlaceholder(),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSpacing.xl,
                    children: [
                      const SizedBox(
                        width: 135,
                        height: 200,
                        child: SkeletonPlaceholder(),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSpacing.md,
                          children: [
                            const SizedBox(
                              height: 32,
                              width: double.infinity,
                              child: SkeletonPlaceholder(),
                            ),
                            const SizedBox(
                              height: 32,
                              width: 140,
                              child: SkeletonPlaceholder(),
                            ),
                            const SizedBox(
                              height: 20,
                              width: 100,
                              child: SkeletonPlaceholder(),
                            ),
                            const SizedBox(
                              height: 20,
                              width: 160,
                              child: SkeletonPlaceholder(),
                            ),
                            const SizedBox(
                              height: 20,
                              width: 200,
                              child: SkeletonPlaceholder(),
                            ),
                            Wrap(
                              spacing: AppSpacing.md,
                              runSpacing: AppSpacing.md,
                              children: List.generate(
                                3,
                                (index) => const SizedBox(
                                  width: 70,
                                  height: 32,
                                  child: SkeletonPlaceholder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const SizedBox(
                    height: 28,
                    width: 150,
                    child: SkeletonPlaceholder(),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...List.generate(
                    4,
                    (index) => SizedBox(
                      height: 16,
                      width: index == 3 ? 200 : double.infinity,
                      child: const SkeletonPlaceholder(),
                    ),
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
