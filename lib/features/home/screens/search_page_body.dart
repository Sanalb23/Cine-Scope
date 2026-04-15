import 'package:cine_scope/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SearchPageBody extends StatefulWidget {
  const SearchPageBody({super.key});

  @override
  State<SearchPageBody> createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          ),
          controller: _searchController,
          trailing: [Icon(Icons.search)],
          hintText: 'Search...',
          onChanged: (value) {
            // TODO: implement search
          },
        ),
      ],
    );
  }
}
