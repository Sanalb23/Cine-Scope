import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:cine_scope/features/movies/domain/entities/movie_summary.dart';
import 'package:cine_scope/features/movies/presentation/utils/movies_list.dart';
import 'package:cine_scope/features/pagination/models/paginated_state.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:cine_scope/core/utils/scroll_to_top_button.dart';
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

    return ScrollToTopButton(
      builder: (context, controller) {
        return PaginatedScrollHandler(
          fetchCallback: fetchCallback,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: MediaQuery.of(
                context,
              ).padding.copyWith(left: 0, right: 0),
              viewPadding: MediaQuery.of(
                context,
              ).viewPadding.copyWith(left: 0, right: 0),
            ),
            child: CustomScrollView(
              controller: controller,
              shrinkWrap: true,
              slivers: [
                if (title.isNotEmpty)
                  SliverAppBar(
                    leadingWidth: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    floating: true,
                    snap: true,
                    title: Text(title, style: context.textTheme.headlineSmall),
                    actions: actions,
                  ),
                if (tags != null)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    sliver: SliverToBoxAdapter(child: tags),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                    bottom: listSpacing,
                    right: AppSpacing.lg,
                    left: AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: MoviesList(
                      state: state,
                      retryCallback: retryCallback,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
