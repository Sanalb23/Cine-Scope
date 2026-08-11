import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/home/presentation/utils/favorites_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/home_drawer.dart';
import 'package:cine_scope/features/home/presentation/utils/home_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/home/presentation/utils/search_movies_list.dart';
import 'package:cine_scope/features/home/presentation/utils/switch_theme_button.dart';
import 'package:cine_scope/features/home/presentation/utils/watch_list_list_tile.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:cine_scope/features/movies/presentation/favorites_body.dart';
import 'package:cine_scope/features/movies/presentation/watch_list_body.dart';
import 'package:easy_localization/easy_localization.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr(), style: context.textTheme.displayMedium),
        centerTitle: false,
        actionsPadding: const EdgeInsets.only(right: AppSpacing.xxxl),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            width: context.screenWidth * 0.25,
            child: const MovieSearchBar(),
          ),
          const SwitchThemeButton(),
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
                      HomeListTile(),
                      FavoritesListTile(),
                      WatchListListTile(),
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
