import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerButton extends StatelessWidget {
  final String? trailerPath;
  const TrailerButton({super.key, required this.trailerPath});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: trailerPath == null
          ? null
          : () async {
              await launchUrl(Uri.parse(trailerPath!));
            },
      child: trailerPath != null
          ? Row(
              mainAxisSize: .min,
              spacing: AppSpacing.md,
              children: [
                Icon(Icons.play_arrow),
                Text(
                  'watch_trailer'.tr(),
                  style: context.textTheme.titleMedium,
                ),
              ],
            )
          : Text(
              'no_trailer_available'.tr(),
              style: context.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withValues(
                  alpha: 0.3,
                ),
              ),
            ),
    );
  }
}
