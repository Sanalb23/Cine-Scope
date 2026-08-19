import 'package:cached_network_image/cached_network_image.dart';
import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_provider_regions_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchProvidersPanel extends StatelessWidget {
  final int movieId;

  const WatchProvidersPanel({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('watch_providers'.tr()),
      childrenPadding: const EdgeInsets.all(AppSpacing.md),
      children: [WatchProvidersContent(movieId: movieId)],
    );
  }
}

class WatchProvidersContent extends ConsumerWidget {
  final int movieId;

  const WatchProvidersContent({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionsAsync = ref.watch(movieWatchProviderRegionsProvider);
    final selectedRegion = ref.watch(selectedWatchProviderRegionProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: regionsAsync.when(
            data: (regions) {
              return DropdownButtonFormField<String>(
                initialValue: selectedRegion,
                decoration: InputDecoration(
                  fillColor: context.colors.primaryContainer,
                  hoverColor: context.colors.primaryContainer.darken(5),
                  filled: true,
                  labelStyle: TextStyle(
                    color: context.colors.onPrimaryContainer,
                  ),
                  labelText: 'region'.tr(),
                  border: const OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                ),
                isExpanded: true,
                items: regions.map((region) {
                  return DropdownMenuItem(
                    value: region.iso31661,
                    child: Text(
                      region.nativeName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null && value != selectedRegion) {
                    ref
                        .read(selectedWatchProviderRegionProvider.notifier)
                        .setRegion(value);
                  }
                },
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => Text('error_loading_regions'.tr()),
          ),
        ),

        if (selectedRegion != null) _WatchProvidersList(movieId: movieId),
      ],
    );
  }
}

class _WatchProvidersList extends ConsumerWidget {
  final int movieId;

  const _WatchProvidersList({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchProvidersAsync = ref.watch(movieWatchProvidersProvider(movieId));

    return watchProvidersAsync.when(
      data: (providersMap) {
        if (providersMap.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text('no_watch_providers_found'.tr()),
          );
        }

        return Wrap(
          runSpacing: AppSpacing.lg,
          spacing: AppSpacing.lg,
          children: providersMap.entries.map((entry) {
            final type = entry.key;
            final providers = entry.value;

            if (providers.isEmpty) return const SizedBox.shrink();

            String title = '';
            switch (type) {
              case WatchProviderType.flatrate:
                title = 'stream'.tr();
                break;
              case WatchProviderType.rent:
                title = 'rent'.tr();
                break;
              case WatchProviderType.buy:
                title = 'buy'.tr();
                break;
              case WatchProviderType.ads:
                title = 'ads'.tr();
                break;
              case WatchProviderType.free:
                title = 'free'.tr();
                break;
            }

            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.primaryContainer.darken(5),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(title, style: context.textTheme.titleMedium),
                  ),
                  Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: providers.map((provider) {
                      return Column(
                        spacing: AppSpacing.sm,
                        children: [
                          if (provider.logoPath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: provider.logoPath!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: context.colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(Icons.movie, size: 20),
                            ),
                          SizedBox(
                            width: 60,
                            child: Text(
                              provider.name,
                              style: context.textTheme.bodySmall,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            );
          }).toList(),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Text('error_loading_watch_providers'.tr()),
      ),
    );
  }
}
