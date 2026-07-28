import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/home/presentation/utils/favorites_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:cine_scope/features/home/presentation/utils/watch_list_list_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                'app_name'.tr(),
                style: context.textTheme.headlineMedium,
              ),
            ),
          ),
          const FavoritesListTile(),
          const WatchListListTile(),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LanguageDropdownMenu(),
          ),
        ],
      ),
    );
  }
}
