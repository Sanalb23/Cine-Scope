import 'package:cine_scope/core/theme/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchThemeButton extends ConsumerWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return IconButton(
      onPressed: () {
        ref.read(appThemeProvider.notifier).toggleTheme();
      },
      icon: Icon(theme == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
    );
  }
}
