import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/movie_notification_state_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class CountDownBanner extends ConsumerWidget {
  const CountDownBanner({
    super.key,
    required this.movieId,
    required this.movieTitle,
    required this.releaseDate,
    required this.daysUntilRelease,
  });
  final int movieId;
  final String movieTitle;
  final DateTime releaseDate;
  final int daysUntilRelease;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(
      movieNotificationStateProvider(movieId),
    );
    final notificationStateNotifier = ref.read(
      movieNotificationStateProvider(movieId).notifier,
    );

    ref.listen(movieNotificationStateProvider(movieId), (previous, next) {
      if (next is AsyncError && !next.isLoading) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('error'.tr()),
            content: Text(next.error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ok'.tr()),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: Text('open_settings'.tr()),
              ),
            ],
          ),
        );
      }
    });

    final isActive = notificationState.value ?? false;

    final activeForegroundColor = Colors.green.shade50;

    return Opacity(
      opacity: daysUntilRelease == 0 || notificationState.isLoading ? 0.5 : 1,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: isActive && daysUntilRelease != 0
              ? Colors.green
              : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
        ),
        onPressed: daysUntilRelease == 0 || notificationState.isLoading
            ? null
            : () => notificationStateNotifier.toggleState(
                movieTitle,
                releaseDate,
              ),
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive && daysUntilRelease != 0
                    ? Colors.green.shade600
                    : context.theme.colorScheme.tertiaryContainer,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Icon(
                daysUntilRelease == 0
                    ? Icons.calendar_today
                    : isActive
                    ? Icons.check
                    : Icons.notifications_rounded,
                size: 32,
                color: isActive && daysUntilRelease != 0
                    ? activeForegroundColor
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  isActive && daysUntilRelease != 0
                      ? 'notification_set'.tr()
                      : switch (daysUntilRelease) {
                          0 => 'releases_today'.tr(),
                          1 => 'releases_tomorrow'.tr(),
                          _ => 'releasing_in_days'.tr(
                            namedArgs: {'days': daysUntilRelease.toString()},
                          ),
                        },
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isActive && daysUntilRelease != 0
                        ? activeForegroundColor
                        : null,
                  ),
                ),
                Text(
                  isActive && daysUntilRelease != 0
                      ? 'youll_get_notified_when_it_releases'.tr()
                      : switch (daysUntilRelease) {
                          0 => 'get_your_popcorn_ready'.tr(),
                          _ => 'tap_to_get_notified'.tr(),
                        },
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isActive ? activeForegroundColor : null,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (daysUntilRelease != 0) ...[
              Icon(
                Icons.chevron_right,
                size: 32,
                color: isActive ? activeForegroundColor : null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
