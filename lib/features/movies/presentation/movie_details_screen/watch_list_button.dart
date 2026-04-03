import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/watch_list_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WatchListButton extends ConsumerWidget {
  const WatchListButton({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInWatchList = ref.watch(isInWatchListProvider(movieId));

    return AppBarButton(
      icon: isInWatchList ? Icons.watch_later : Icons.watch_later_outlined,
      onPressed: () {
        ref.read(watchListProvider.notifier).toggleInWatchList(movieId);
      },
    );
  }
}
