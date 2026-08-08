import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieReleaseDate extends ConsumerWidget {
  const MovieReleaseDate({super.key, required this.releaseDate});
  final DateTime releaseDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formattedReleaseDate = DateFormat.yMMMMd(
      context.locale.toLanguageTag(),
    ).format(releaseDate);

    return Text(
      '${'release_date'.tr()}: $formattedReleaseDate',
      style: context.textTheme.titleMedium,
    );
  }
}
