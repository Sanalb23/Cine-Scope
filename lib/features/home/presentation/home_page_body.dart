import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum.dart';
import 'package:cine_scope/core/features/movies/data/enum/movie_list_category/movie_list_category_enum_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/movies_by_category_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageBody extends ConsumerStatefulWidget {
  const HomePageBody({super.key});

  @override
  ConsumerState<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends ConsumerState<HomePageBody> {
  late MovieListCategory _movieListCategory;

  @override
  void initState() {
    super.initState();

    _movieListCategory = MovieListCategory.popular;
  }

  PopupMenuItem _buildPopupMenuItem(MovieListCategory category) {
    return PopupMenuItem(
      value: category,
      child: Row(
        spacing: AppSpacing.sm,
        children: [Icon(category.icon), Text(category.title)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listState = ref.watch(moviesByCategoryProvider(_movieListCategory));

    return Column(
      spacing: AppSpacing.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${_movieListCategory.title} Movies',
              style: context.textTheme.headlineSmall,
            ),
            Spacer(),
            PopupMenuButton(
              tooltip: 'Explore movies',
              icon: Icon(Icons.filter_list),
              itemBuilder: (context) {
                return [
                  _buildPopupMenuItem(MovieListCategory.popular),
                  _buildPopupMenuItem(MovieListCategory.topRated),
                ];
              },
              onSelected: (value) {
                setState(() {
                  _movieListCategory = value;
                });
              },
            ),
          ],
        ),
        Expanded(
          child: MoviesList(
            movies: listState.movies,
            onFetchMore: listState.fetchMore,
          ),
        ),
      ],
    );
  }
}
