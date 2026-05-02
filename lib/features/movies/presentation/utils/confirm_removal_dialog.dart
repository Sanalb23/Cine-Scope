import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<bool> confirmRemoval(
  BuildContext context,
  String listNameKey,
  String movieTitle,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'remove_from_list_question'.tr(
          namedArgs: {'list_name': listNameKey.tr()},
        ),
      ),
      content: Text(
        'confirm_removal_message'.tr(
          namedArgs: {'list_name': listNameKey.tr(), 'movie_title': movieTitle},
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('cancel'.tr()),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('remove'.tr()),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
