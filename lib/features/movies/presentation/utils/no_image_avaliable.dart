import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoImageAvaliable extends StatelessWidget {
  const NoImageAvaliable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.sm,
      children: [
        const Icon(Icons.error),
        Text('no_image_available'.tr(), style: context.textTheme.labelSmall),
      ],
    );
  }
}
