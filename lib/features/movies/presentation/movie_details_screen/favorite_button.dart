import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/favorite_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInFavorites = ref.watch(isFavoriteProvider(movieId));

    return AppBarButton(
      icon: isInFavorites ? Icons.bookmark : Icons.bookmark_border,
      onPressed: () {
        ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movieId);
      },
    );
  }
}
