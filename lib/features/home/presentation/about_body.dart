import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/core/utils/custom_sliver_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AboutBody extends StatelessWidget {
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(titleText: 'about'.tr()),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),
                    Image.asset('assets/images/logo/icon_logo.png', height: 75),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'v0.1.0',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xxxl),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo/tmdb_logo.png',
                              height: 60,
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            Text(
                              'tmdb_attribution'.tr(),
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyMedium?.copyWith(
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
