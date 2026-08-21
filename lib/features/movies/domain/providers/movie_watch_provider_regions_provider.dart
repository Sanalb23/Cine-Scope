import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieWatchProviderRegionsProvider = FutureProvider.autoDispose<List<WatchProviderRegion>>((ref) async {
  final repository = ref.watch(movieWatchProvidersRepositoryProvider);
  final locale = ref.watch(localeProvider).toLanguageTag();

  return repository.getWatchProviderRegions(locale: locale);
});
