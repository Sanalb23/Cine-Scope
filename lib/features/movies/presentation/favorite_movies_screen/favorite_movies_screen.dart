import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FavoriteMoviesScreen extends StatelessWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favorites', style: context.textTheme.headlineSmall),
      ),
    );
  }
}
