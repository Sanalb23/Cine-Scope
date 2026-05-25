import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/local/movie_notification_state_provider.dart';
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
            title: const Text('Error'),
            content: Text(next.error.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }
    });

    return Opacity(
      opacity: daysUntilRelease == 0 || notificationState.isLoading ? 0.5 : 1,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: notificationState.value ?? false
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
                color: notificationState.value ?? false
                    ? Colors.green.shade600
                    : context.theme.colorScheme.tertiaryContainer,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Icon(
                daysUntilRelease == 0
                    ? Icons.calendar_today
                    : notificationState.value ?? false
                    ? Icons.check
                    : Icons.notifications_rounded,
                size: 32,
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  notificationState.value ?? false
                      ? 'Notification set'
                      : switch (daysUntilRelease) {
                          0 => 'RELEASES TODAY!',
                          1 => 'RELEASES TOMORROW',
                          _ => 'RELEASING IN $daysUntilRelease DAYS',
                        },
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notificationState.value ?? false
                      ? 'You\'ll get notified when it releases'
                      : switch (daysUntilRelease) {
                          0 => 'Get your popcorn ready',
                          _ => 'Tap to get notified',
                        },
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            if (daysUntilRelease != 0) ...[
              Icon(
                Icons.chevron_right,
                size: 32,
                color: context.theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
