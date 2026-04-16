import 'package:cine_scope/features/settings/domain/providers/settings_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeNotifierProvider = NotifierProvider<AppThemeNotifier, ThemeMode>(
  AppThemeNotifier.new,
);

class AppThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final theme = ref.watch(settingsRepositoryProvider).getTheme();
    return theme;
  }

  Future<void> setTheme(ThemeMode theme) async {
    await ref.read(settingsRepositoryProvider).setTheme(theme);
    state = theme;
  }
}
