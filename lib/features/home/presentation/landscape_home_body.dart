import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/home/presentation/utils/favorites_list_tile.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:cine_scope/features/home/presentation/utils/movie_search_bar.dart';
import 'package:cine_scope/features/home/presentation/utils/search_movies_list.dart';
import 'package:cine_scope/features/home/presentation/utils/switch_theme_button.dart';
import 'package:cine_scope/features/home/presentation/utils/watch_list_list_tile.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/search_movies/search_query_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandscapeHomeBody extends ConsumerWidget {
  const LandscapeHomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearching = ref.watch(searchQueryProvider).isNotEmpty;

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
      body: Row(
        children: [
          SizedBox(
            width: context.screenWidth * 0.2,
            child: NavigationDrawer(
              children: [FavoritesListTile(), WatchListListTile()],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: isSearching
                  ? const SearchMoviesList()
                  : const HomePageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
