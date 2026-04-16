import 'package:cine_scope/features/settings/data/settings_repository.dart';
import 'package:cine_scope/features/settings/domain/providers/settings_datasource_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final settingsDatasource = ref.watch(settingsDatasourceProvider);
  return SettingsRepository(settingsLocalDatasource: settingsDatasource);
});
