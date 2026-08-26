import 'package:cine_scope/core/extensions/ref_extensions.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_repository_provider.dart';
import 'package:cine_scope/features/settings/domain/providers/settings_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedWatchProviderRegionNotifier extends Notifier<String?> {
  @override
  String? build() {
    return ref.watch(settingsRepositoryProvider).getWatchProviderRegion();
  }

  Future<void> setRegion(String? region) async {
    if (region != null && region != state) {
      state = region;
      await ref.read(settingsRepositoryProvider).setWatchProviderRegion(region);
    }
  }
}

final selectedWatchProviderRegionProvider =
    NotifierProvider<SelectedWatchProviderRegionNotifier, String?>(
      SelectedWatchProviderRegionNotifier.new,
    );

final movieWatchProvidersProvider = FutureProvider.autoDispose
    .family<Map<WatchProviderType, List<WatchProvider>>, int>((
      ref,
      movieId,
    ) async {
      ref.cache(const Duration(minutes: 1));

      final repository = ref.watch(movieWatchProvidersRepositoryProvider);

      final locale = ref.watch(localeProvider).toLanguageTag();
      final region = ref.watch(selectedWatchProviderRegionProvider);

      if (region == null) return {};

      return repository.getWatchProviders(
        movieId: movieId,
        region: region,
        locale: locale,
      );
    });
