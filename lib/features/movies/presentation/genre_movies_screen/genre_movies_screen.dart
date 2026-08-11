import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/providers/notifiers/remote/genre_movies_provider.dart';
import 'package:cine_scope/features/movies/presentation/utils/paginated_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreMoviesScreen extends ConsumerWidget {
  const GenreMoviesScreen({
    super.key,
    required this.genreId,
    required this.genreName,
  });

  final int genreId;
  final String genreName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(genreMoviesProvider(genreId));

    return Scaffold(
      appBar: AppBar(title: Text(genreName), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
          ),
          child: PaginatedMoviesList(
            fetchCallback: () =>
                ref.read(genreMoviesProvider(genreId).notifier).fetchMore(),
            retryCallback: () =>
                ref.read(genreMoviesProvider(genreId).notifier).retry(),
            state: state,
          ),
        ),
      ),
    );
  }
}
