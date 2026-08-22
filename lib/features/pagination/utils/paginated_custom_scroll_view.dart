import 'package:cine_scope/core/utils/scroll_to_top_button.dart';
import 'package:cine_scope/features/pagination/utils/paginated_scroll_handler.dart';
import 'package:flutter/material.dart';

class PaginatedCustomScrollView extends StatelessWidget {
  const PaginatedCustomScrollView({
    super.key,
    required this.fetchCallback,
    required this.slivers,
  });

  final VoidCallback fetchCallback;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
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
              slivers: slivers,
            ),
          ),
        );
      },
    );
  }
}
