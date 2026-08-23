import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.leading,
    required this.titleText,
    this.actions,
  });

  final Widget? leading;
  final String titleText;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: leading,
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: true,
      actionsPadding: EdgeInsets.only(right: AppSpacing.xl),
      title: Text(titleText, style: context.textTheme.headlineSmall),
      actions: actions,
    );
  }
}
