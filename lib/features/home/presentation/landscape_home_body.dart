import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/home/presentation/utils/drawer_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/home_drawer.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/home/presentation/utils/search_movies_list.dart';
import 'package:cine_scope/features/home/presentation/utils/switch_theme_button.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/favorites_body.dart';
import 'package:cine_scope/features/movies/presentation/watch_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeHomeBody extends ConsumerWidget {
  const LandscapeHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBody = ref.watch(homeBodyProvider);
    final isSearching = ref.watch(searchQueryProvider).isNotEmpty;

    Widget activeBody;
    if (isSearching) {
      activeBody = const SearchMoviesList();
    } else {
      switch (selectedBody) {
        case HomeBody.home:
          activeBody = const HomePageBody();
          break;
        case HomeBody.favorites:
          activeBody = const FavoritesBody();
          break;
        case HomeBody.watchList:
          activeBody = const WatchListBody();
          break;
      }
    }

    var body = Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: activeBody,
    );

    final appbarSpacer = const SizedBox(width: AppSpacing.md);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Image.asset('assets/images/logo/icon_logo.png'),
        ),
        centerTitle: false,
        actionsPadding: const EdgeInsets.only(
          right: NavigationToolbar.kMiddleSpacing,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            width: context.screenWidth * 0.25,
            child: const MovieSearchBar(),
          ),
          appbarSpacer,
          const SwitchThemeButton(),
          appbarSpacer,
          const LanguageDropdownMenu(),
        ],
      ),

      drawer: context.isWideScreen ? null : const HomeDrawer(),

      body: context.isWideScreen
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (context.screenWidth * 0.15).clamp(180, 300),
                  child: const NavigationDrawer(
                    children: [
                      DrawerListTile(
                        icon: Icons.home,
                        title: 'home',
                        homeBody: HomeBody.home,
                      ),
                      DrawerListTile(
                        icon: Icons.bookmark,
                        title: 'favorites',
                        homeBody: HomeBody.favorites,
                      ),
                      DrawerListTile(
                        icon: Icons.watch_later,
                        title: 'watch_list',
                        homeBody: HomeBody.watchList,
                      ),
                    ],
                  ),
                ),
                Expanded(child: body),
              ],
            )
          : body,
    );
  }
}
