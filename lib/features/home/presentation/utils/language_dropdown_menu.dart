import 'package:cine_scope/core/providers/locale_provider.dart';
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
      icon: const Icon(Icons.language),
      underline: const SizedBox(),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          context.setLocale(newLocale);
          ref.read(localeProvider.notifier).setLocale(newLocale);
        }
      },
      items: context.supportedLocales.map((Locale locale) {
        final label = locale.languageCode == 'es' ? 'Español' : 'English';
        return DropdownMenuItem<Locale>(value: locale, child: Text(label));
      }).toList(),
    );
  }
}
