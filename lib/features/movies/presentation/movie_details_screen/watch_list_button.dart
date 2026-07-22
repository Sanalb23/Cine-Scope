import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/is_in_watch_list_provider.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/movie_notification_state_provider.dart';
import 'package:cine_scope/features/movies/presentation/movie_details_screen/appbar_button.dart';
import 'package:cine_scope/features/movies/presentation/utils/confirm_removal_dialog.dart';
import 'package:cine_scope/features/settings/domain/providers/settings_repository_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';

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
    final isWideScreen = context.screenWidth > 600;

    final isInWatchList = ref.watch(isInWatchListProvider(movieId));

    final hasSeenWatchlistTooltip = ref
        .watch(settingsRepositoryProvider)
        .hasSeenWatchlistTooltip();

    ref.listen(movieNotificationStateProvider(movieId), (previous, next) {
      if (!isInWatchList &&
          (previous?.value?.isScheduled == false &&
              next.value?.isScheduled == true) &&
          !hasSeenWatchlistTooltip) {
        showPopover(
          context: context,
          width: (context.screenWidth * 0.9).clamp(200, 400),
          backgroundColor: context.colors.surfaceContainerHigh,
          direction: PopoverDirection.bottom,
          bodyBuilder: (context) => Padding(
            padding: const EdgeInsets.all(16),
            child: Text('reminder_saves_to_watchlist'.tr()),
          ),
          onPop: () async {
            await ref
                .read(settingsRepositoryProvider)
                .setHasSeenWatchlistTooltip(true);
          },
        );
      }
    });

    return AppBarButton(
      icon: isInWatchList ? Icons.watch_later : Icons.watch_later_outlined,
      text: isWideScreen
          ? (isInWatchList
                ? 'remove_from'.tr(args: ['watch_list'.tr()])
                : 'add_to'.tr(args: ['watch_list'.tr()]))
          : null,
      onPressed: () async {
        if (isInWatchList &&
            !(await confirmRemoval(context, 'watch_list', movieTitle))) {
          return;
        }
        ref.read(isInWatchListProvider(movieId).notifier).toggleWatchList();
      },
    );
  }
}
