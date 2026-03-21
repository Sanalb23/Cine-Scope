import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CineScope', style: context.textTheme.displaySmall),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'CineScope',
                  style: context.textTheme.headlineMedium,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Favorites'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.watch_later),
              title: const Text('Watch Later'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
