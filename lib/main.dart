import 'package:cine_scope/core/utils/init_timezone.dart';
import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/core/theme/app_theme_provider.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/home_screen.dart';
import 'package:cine_scope/core/providers/prefs_instance_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cine_scope/core/globals.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/movie_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  if (!kIsWeb) {
    await initTimeZone();
  }

  runApp(
    ProviderScope(
      overrides: [prefsInstanceProvider.overrideWithValue(prefs)],
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
      navigatorKey: navigatorKey,
      title: 'CineScope',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: context.locale,
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name != null &&
            settings.name!.startsWith('/movie_details_screen/')) {
          final movieIdStr = settings.name!.split('/').last;
          final movieId = int.tryParse(movieIdStr);
          if (movieId != null) {
            return MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(id: movieId),
            );
          }
        }
        return null;
      },
    );
  }
}
