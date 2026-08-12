import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageDropdownMenu extends ConsumerWidget {
  const LanguageDropdownMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return DropdownButton<Locale>(
      value: currentLocale,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        child: const Icon(Icons.language),
      ),
      underline: const SizedBox(),
      borderRadius: BorderRadius.circular(8),
      onChanged: (Locale? newLocale) async {
        if (newLocale != null) {
          await context.setLocale(newLocale);
          ref.read(localeProvider.notifier).setLocale(newLocale);
        }
      },
      items: context.supportedLocales.map((Locale locale) {
        final label = switch (locale.languageCode) {
          'es' => 'Español',
          'en' => 'English',
          _ => locale.languageCode,
        };
        return DropdownMenuItem<Locale>(value: locale, child: Text(label));
      }).toList(),
    );
  }
}
