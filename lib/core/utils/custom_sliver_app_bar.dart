import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.titleText, this.actions});

  final String titleText;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leadingWidth: 0,
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      floating: true,
      snap: true,
      title: Text(titleText, style: context.textTheme.headlineSmall),
      actions: actions,
    );
  }
}
