import 'package:flutter/material.dart';

Future<bool> confirmRemoval(
  BuildContext context,
  String listName,
  String movieTitle,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Remove from $listName?'),
      content: Text(
        'Are you sure you want to remove "$movieTitle" from your $listName?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Remove'),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
