import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';

class PaginatedMoviesList extends StatelessWidget {
  const PaginatedMoviesList({
    super.key,
    required this.fetchCallback,
    required this.retryCallback,
    required this.state,
    this.actions = const [],
    this.title = '',
  });
  final VoidCallback fetchCallback;
  final VoidCallback retryCallback;
  final PaginatedState<MovieSummary> state;
  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return PaginatedScrollHandler(
      fetchCallback: fetchCallback,
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
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

          MoviesList(state: state, retryCallback: retryCallback),
        ],
      ),
    );
  }
}
