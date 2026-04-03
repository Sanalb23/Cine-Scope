import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBarButton(icon: Icons.bookmark_border, onPressed: () {});
  }
}
