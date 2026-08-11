import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginatedMoviesList extends ConsumerWidget {
  const PaginatedMoviesList({
    super.key,
    required this.fetchCallback,
    required this.retryCallback,
    required this.state,
    this.actions = const [],
    this.title = '',
    this.tags,
  });
  final VoidCallback fetchCallback;
  final VoidCallback retryCallback;
  final PaginatedState<MovieSummary> state;
  final String title;
  final List<Widget> actions;
  final Widget? tags;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const listSpacing = AppSpacing.xl;

    return PaginatedScrollHandler(
      fetchCallback: fetchCallback,
      child: ListView(
        padding: const EdgeInsets.only(bottom: listSpacing),
        shrinkWrap: true,
        children: [
          if (title.isNotEmpty) ...[
            SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: context.textTheme.headlineSmall),
                  const Spacer(),
                  ...actions,
                ],
              ),
            ),
          ],

          if (tags != null) tags!,

          MoviesList(state: state, retryCallback: retryCallback),
        ],
      ),
    );
  }
}
