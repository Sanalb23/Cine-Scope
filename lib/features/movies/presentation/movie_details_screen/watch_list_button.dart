import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_in_watch_list_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/confirm_removal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListButton extends ConsumerWidget {
  const WatchListButton({
    super.key,
    required this.movieId,
    required this.movieTitle,
  });

  final int movieId;
  final String movieTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInWatchList = ref.watch(isInWatchListProvider(movieId));

    return AppBarButton(
      icon: isInWatchList ? Icons.watch_later : Icons.watch_later_outlined,
      onPressed: () async {
        if (isInWatchList &&
            !(await confirmRemoval(context, 'watch list', movieTitle))) {
          return;
        }
        ref.read(isInWatchListProvider(movieId).notifier).toggleWatchList();
      },
    );
  }
}
