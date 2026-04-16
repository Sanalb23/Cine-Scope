import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/home/presentation/search_page_body.dart';
import 'package:cine_scope/features/movies/presentation/favorite_movies_screen/favorite_movies_screen.dart';
import 'package:cine_scope/features/movies/presentation/watch_list_screen/watch_list_screen.dart';
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
        title: Text('CineScope', style: context.textTheme.displaySmall),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'CineScope',
                  style: context.textTheme.headlineMedium,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Favorites'),
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
              title: const Text('Watch Later'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WatchListScreen(),
                  ),
                );
              },
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
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
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
