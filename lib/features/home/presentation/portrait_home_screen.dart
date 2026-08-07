import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:cine_scope/features/home/presentation/home_body_content.dart';
import 'package:cine_scope/features/home/presentation/search_page_body.dart';
import 'package:cine_scope/features/home/presentation/utils/home_drawer.dart';
import 'package:cine_scope/features/home/presentation/utils/switch_theme_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortraitHomeScreen extends ConsumerStatefulWidget {
  const PortraitHomeScreen({super.key});

  @override
  ConsumerState<PortraitHomeScreen> createState() => _PortraitHomeScreenState();
}

class _PortraitHomeScreenState extends ConsumerState<PortraitHomeScreen> {
  late final PageController _pageController;
  int _selectedPage = 0;

  final _pages = [
    Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: const HomeBodyContent(),
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
    ref.listen<HomeBody>(homeBodyProvider, (previous, next) {
      if (_selectedPage != 0) {
        setState(() {
          animateToPage(0);
          _selectedPage = 0;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr(), style: context.textTheme.displaySmall),
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(right: AppSpacing.md),
        actions: [const SwitchThemeButton()],
      ),

      drawer: const HomeDrawer(),

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
          if (index == 0) {
            ref.read(homeBodyProvider.notifier).switchHomeBody(HomeBody.home);
          }
          setState(() {
            animateToPage(index);

            _selectedPage = index;
          });
        },
      ),
    );
  }

  void animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
