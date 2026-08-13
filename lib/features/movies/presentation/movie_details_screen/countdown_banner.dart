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
            ],
          ),
        );
        return;
      }

      if (next.hasValue && !next.isLoading) {
        final stateValue = next.value;
        if (stateValue != null &&
            stateValue.status == MovieNotificationStatus.error) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('error'.tr()),
              content: Text(stateValue.errorMessage ?? ''),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ok'.tr()),
                ),
                if (stateValue.errorType ==
                    MovieNotificationErrorType.permission)
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
      }
    });

    final areRemindersActive = notificationState.value?.isScheduled ?? false;

    final isEnabled = daysUntilRelease > 0 && !notificationState.isLoading;

    final title = areRemindersActive
        ? 'notification_set'.tr()
        : switch (daysUntilRelease) {
            0 => 'releases_today'.tr(),
            1 => 'releases_tomorrow'.tr(),
            _ => 'releasing_in_days'.tr(
              namedArgs: {'days': daysUntilRelease.toString()},
            ),
          };

    final description = areRemindersActive
        ? 'youll_get_notified_when_it_releases'.tr()
        : switch (daysUntilRelease) {
            0 => 'get_your_popcorn_ready'.tr(),
            _ => 'tap_to_get_notified'.tr(),
          };

    final icon = daysUntilRelease == 0
        ? Icons.calendar_today
        : areRemindersActive
        ? Icons.check
        : Icons.notifications_rounded;

    return _BaseCountdownBanner(
      title: title,
      description: description,
      isActive: areRemindersActive,
      onClick: isEnabled
          ? () => notificationStateNotifier.toggleState(movieTitle, releaseDate)
          : null,
      icon: icon,
    );
  }
}

class DeactivatedCountdownBanner extends StatelessWidget {
  const DeactivatedCountdownBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseCountdownBanner(
      title: 'native_reminders'.tr(),
      description: 'native_reminders_description'.tr(),
      isActive: false,
      onClick: null,
      icon: Icons.notification_important_rounded,
    );
  }
}

class _BaseCountdownBanner extends StatelessWidget {
  const _BaseCountdownBanner({
    required this.title,
    required this.description,
    required this.isActive,
    required this.icon,
    this.onClick,
  });

  final String title;
  final String description;
  final bool isActive;
  final VoidCallback? onClick;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive ? Colors.green : null;

    final iconBackgroundColor = isActive
        ? Colors.green.shade600
        : context.theme.colorScheme.tertiaryContainer;

    final foregroundColor = isActive ? Colors.green.shade50 : null;

    return Opacity(
      opacity: onClick == null ? 0.5 : 1,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
        ),
        onPressed: onClick,
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Icon(icon, size: 32, color: foregroundColor),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: foregroundColor,
                    ),
                  ),
                  Text(
                    description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
            if (onClick != null) ...[
              Icon(Icons.chevron_right, size: 32, color: foregroundColor),
            ],
          ],
        ),
      ),
    );
  }
}
