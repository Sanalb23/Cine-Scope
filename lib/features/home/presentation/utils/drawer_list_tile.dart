import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerListTile extends ConsumerWidget {
  final IconData icon;
  final String title;
  final HomeBody homeBody;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.homeBody,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBody = ref.watch(homeBodyProvider);
    final isSelected = selectedBody == homeBody;

    return ListTile(
      selected: isSelected,
      leading: Icon(icon),
      title: Text(title.tr()),
      onTap: () {
        ref.read(homeBodyProvider.notifier).switchHomeBody(homeBody);
        if (!context.isWideScreen) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
