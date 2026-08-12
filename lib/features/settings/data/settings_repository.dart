import 'package:cine_scope/features/settings/data/settings_local_datasource.dart';
import 'package:flutter/material.dart';

class SettingsRepository {
  final SettingsLocalDatasource _settingsLocalDatasource;

  SettingsRepository({required SettingsLocalDatasource settingsLocalDatasource})
    : _settingsLocalDatasource = settingsLocalDatasource;

  ThemeMode getTheme() {
    final theme = _settingsLocalDatasource.getTheme();

    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    switch (theme) {
      case ThemeMode.dark:
        await _settingsLocalDatasource.setTheme('dark');
        break;
      case ThemeMode.light:
        await _settingsLocalDatasource.setTheme('light');
        break;
      default:
        await _settingsLocalDatasource.setTheme('dark');
    }
  }

  bool hasSeenWatchlistTooltip() {
    return _settingsLocalDatasource.hasSeenWatchlistTooltip();
  }

  Future<void> setHasSeenWatchlistTooltip(bool seen) async {
    await _settingsLocalDatasource.setHasSeenWatchlistTooltip(seen);
  }
}
