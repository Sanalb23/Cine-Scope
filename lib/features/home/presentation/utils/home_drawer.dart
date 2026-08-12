import 'package:cine_scope/core/providers/locale_provider.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:cine_scope/features/home/presentation/utils/drawer_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeProvider);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/images/logo/icon_logo.png'),
            ),
          ),
          const DrawerListTile(
            icon: Icons.home,
            title: 'home',
            homeBody: HomeBody.home,
          ),
          const DrawerListTile(
            icon: Icons.bookmark,
            title: 'favorites',
            homeBody: HomeBody.favorites,
          ),
          const DrawerListTile(
            icon: Icons.watch_later,
            title: 'watch_list',
            homeBody: HomeBody.watchList,
          ),
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
