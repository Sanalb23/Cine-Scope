import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Watch List', style: context.textTheme.headlineSmall),
      ),
    );
  }
}
