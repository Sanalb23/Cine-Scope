import 'package:cine_scope/features/movies/presentation/watch_list_screen/watch_list_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WatchListListTile extends StatelessWidget {
  const WatchListListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.watch_later),
      title: Text('watch_list'.tr()),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WatchListScreen(),
          ),
        );
      },
    );
  }
}
