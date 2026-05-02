import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_favorite_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/confirm_removal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.movieId,
    required this.movieTitle,
  });

  final int movieId;
  final String movieTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInFavorites = ref.watch(isFavoriteProvider(movieId));

    return AppBarButton(
      icon: isInFavorites ? Icons.bookmark : Icons.bookmark_border,
      onPressed: () async {
        if (isInFavorites &&
            !(await confirmRemoval(context, 'favorites', movieTitle))) {
          return;
        }
        ref.read(isFavoriteProvider(movieId).notifier).toggleFavorite();
      },
    );
  }
}
