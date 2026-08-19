import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/movies/domain/entities/watch_provider_region.dart';
import 'package:cine_scope/features/movies/domain/providers/movie_watch_providers_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieWatchProviderRegionsProvider = FutureProvider.autoDispose<List<WatchProviderRegion>>((ref) async {
  final datasource = ref.watch(movieWatchProvidersDatasourceProvider);
  final locale = ref.watch(localeProvider).toLanguageTag();

  return datasource.fetchWatchProviderRegions(locale: locale);
});
