import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          ),
          trailing: [Icon(Icons.search)],
          hintText: 'Search...',
        ),
      ],
    );
  }
}
