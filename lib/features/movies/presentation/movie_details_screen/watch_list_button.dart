import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:flutter/material.dart';

class WatchListButton extends StatelessWidget {
  const WatchListButton({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return AppBarButton(icon: Icons.watch_later_outlined, onPressed: () {});
  }
}
