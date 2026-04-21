import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/movie_card/movie_card.dart';
import 'package:cine_scope/features/movies/presentation/utils/movie_list_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({
    super.key,
    required this.movies,
    required this.onFetchMore,
    this.onRefresh,
  });

  final AsyncValue<List<MovieSummary>> movies;
  final Future<void> Function() onFetchMore;
  final Future<void> Function()? onRefresh;

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool isFetchingMore = false;

  void fetchMore() {
    if (widget.movies.hasValue) {
      setState(() {
        isFetchingMore = true;
      });

      widget.onFetchMore().then((_) {
        if (mounted) {
          setState(() {
            isFetchingMore = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.movies.when(
      data: (movies) {
        if (movies.isEmpty) {
          return Center(
            child: Text(
              'No movies found',
              style: context.textTheme.headlineSmall,
            ),
          );
        }

        Widget grid = GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: AppSpacing.lg,
            crossAxisSpacing: AppSpacing.lg,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        );

        if (widget.onRefresh != null) {
          grid = RefreshIndicator(onRefresh: widget.onRefresh!, child: grid);
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (!isFetchingMore &&
                notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent * 0.9) {
              fetchMore();
            }
            return false;
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              grid,
              const SizedBox(height: AppSpacing.lg),
              if (isFetchingMore) const MovieListSkeleton(isScrollable: false),
            ],
          ),
        );
      },
      loading: () => const MovieListSkeleton(),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }
}
