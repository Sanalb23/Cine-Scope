import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class CountDownBanner extends StatelessWidget {
  const CountDownBanner({super.key, required this.daysUntilRelease});
  final int daysUntilRelease;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: daysUntilRelease == 0 ? 0.5 : 1,
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.lg,
          ),
        ),
        onPressed: daysUntilRelease == 0 ? null : () {},
        child: Row(
          spacing: AppSpacing.md,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.colorScheme.tertiaryContainer,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Icon(
                  daysUntilRelease == 0
                      ? Icons.calendar_today
                      : Icons.notifications_rounded,
                  size: 32,
                  color: context.theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  switch (daysUntilRelease) {
                    0 => 'RELEASES TODAY!',
                    1 => 'RELEASES TOMORROW',
                    _ => 'RELEASING IN $daysUntilRelease DAYS',
                  },
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  daysUntilRelease == 0
                      ? 'Get your popcorn ready'
                      : 'Tap to get notified',
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
