import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:cine_scope/features/settings/data/settings_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsDatasourceProvider = Provider<SettingsLocalDatasource>((ref) {
  final prefs = ref.watch(prefsInstanceProvider);
  return SettingsLocalDatasource(prefs: prefs);
});
