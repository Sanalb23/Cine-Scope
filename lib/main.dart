import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/core/providers/notification_service_provider.dart';
import 'package:cine_scope/core/theme/app_theme_provider.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/home_screen.dart';
import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:cine_scope/core/features/notifications/notification_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");

  final notificationService = NotificationService();
  await notificationService.initNotification();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        prefsInstanceProvider.overrideWithValue(prefs),
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'MX')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLocale = context.locale;
      if (ref.read(localeProvider) != currentLocale) {
        ref.read(localeProvider.notifier).setLocale(currentLocale);
      }
    });

    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: context.locale,
      home: const HomeScreen(),
    );
  }
}
