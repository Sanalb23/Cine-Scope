import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class CountDownBanner extends StatelessWidget {
  const CountDownBanner({super.key, required this.daysUntilRelease});
  final int daysUntilRelease;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: .centerRight,
          end: .centerLeft,
          colors: [
            context.theme.colorScheme.error,
            context.theme.colorScheme.error.withValues(alpha: .5),
          ],
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: Row(
          mainAxisAlignment: .center,
          spacing: AppSpacing.md,
          children: [
            Icon(
              Icons.timer_outlined,
              size: (context.textTheme.titleLarge?.fontSize ?? 0) * 1.5,
            ),
            Text(switch (daysUntilRelease) {
              0 => 'RELEASES TODAY!',
              1 => 'RELEASES TOMORROW',
              _ => 'RELEASING IN $daysUntilRelease DAYS',
            }, style: context.textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
