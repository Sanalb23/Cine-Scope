import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/home/presentation/search_page_body.dart';
import 'package:cine_scope/features/home/presentation/utils/language_dropdown_menu.dart';
import 'package:cine_scope/features/home/presentation/utils/switch_theme_button.dart';
import 'package:cine_scope/features/movies/presentation/favorite_movies_screen/favorite_movies_screen.dart';
import 'package:cine_scope/features/movies/presentation/watch_list_screen/watch_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _selectedPage = 0;

  final _pages = [
    Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: const HomePageBody(),
    ),
    Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: const SearchPageBody(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr(), style: context.textTheme.displaySmall),
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: AppSpacing.md),
        actions: [const SwitchThemeButton()],
      ),

      drawer: Drawer(
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
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: Text('favorites'.tr()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteMoviesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.watch_later),
              title: Text('watch_list'.tr()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WatchListScreen(),
                  ),
                );
              },
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: LanguageDropdownMenu(),
            ),
          ],
        ),
      ),

      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),

      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: 'home'.tr(),
          ),
          NavigationDestination(
            icon: const Icon(Icons.search),
            label: 'search'.tr(),
          ),
        ],
        selectedIndex: _selectedPage,
        onDestinationSelected: (index) {
          setState(() {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );

            _selectedPage = index;
          });
        },
      ),
    );
  }
}
