import 'dart:async';

import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedWatchProviderRegionNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setRegion(String? region) {
    state = region;
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
      final link = ref.keepAlive();

      final timer = Timer(const Duration(minutes: 3), () {
        link.close();
      });

      ref.onDispose(() => timer.cancel());

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
