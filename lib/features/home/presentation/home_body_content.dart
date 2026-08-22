import 'package:cine_scope/features/home/domain/providers/home_body_provider.dart';
import 'package:cine_scope/features/home/presentation/about_body.dart';
import 'package:cine_scope/features/home/presentation/home_page_body.dart';
import 'package:cine_scope/features/movies/presentation/favorites_body.dart';
import 'package:cine_scope/features/movies/presentation/watch_list_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeBodyContent extends ConsumerWidget {
  const HomeBodyContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final body = ref.watch(homeBodyProvider);
    switch (body) {
      case HomeBody.home:
        return const HomePageBody();
      case HomeBody.favorites:
        return const FavoritesBody();
      case HomeBody.watchList:
        return const WatchListBody();
      case HomeBody.about:
        return const AboutBody();
    }
  }
}
