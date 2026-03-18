import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:cine_scope/features/movies/data/models/local/movie_local_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");

  await Hive.initFlutter();

  Hive.registerAdapter(MovieLocalModelAdapter());

  await Hive.openBox<MovieLocalModel>('favorites');
  await Hive.openBox<MovieLocalModel>('watchLater');

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
