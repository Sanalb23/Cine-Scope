import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TryAgainLater extends StatelessWidget {
  const TryAgainLater({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.md,
      children: [
        const Icon(Icons.error_outline, size: 48),
        Text('error'.tr(), style: context.textTheme.headlineSmall),
        Text('please_try_again_later'.tr(), style: context.textTheme.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        ElevatedButton(onPressed: onPressed, child: Text('retry'.tr())),
      ],
    );
  }
}
