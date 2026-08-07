import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesListTile extends ConsumerWidget {
  const FavoritesListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBody = ref.watch(homeBodyProvider);
    final isSelected = selectedBody == HomeBody.favorites;

    return ListTile(
      selected: isSelected,
      leading: const Icon(Icons.bookmark),
      title: Text('favorites'.tr()),
      onTap: () {
        ref.read(homeBodyProvider.notifier).switchHomeBody(HomeBody.favorites);
        if (!context.isWideScreen) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
