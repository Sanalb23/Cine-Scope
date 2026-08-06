import 'package:cine_scope/features/movies/presentation/favorite_movies_screen/favorite_movies_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FavoritesListTile extends StatelessWidget {
  const FavoritesListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.bookmark),
      title: Text('favorites'.tr()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FavoriteMoviesScreen(),
          ),
        );
      },
    );
  }
}
