import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Popular Movies', style: context.textTheme.headlineSmall),
        Expanded(child: Placeholder()),
      ],
    );
  }
}
