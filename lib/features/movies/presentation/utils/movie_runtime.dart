import 'package:cine_scope/core/extensions/duration_extensions.dart';
import 'package:flutter/material.dart';

class MovieRuntime extends StatelessWidget {
  const MovieRuntime({super.key, required this.runtime});

  final int runtime;

  @override
  Widget build(BuildContext context) {
    final runtimeString = Duration(minutes: runtime).hoursAndMinutesString;

    return Text(runtimeString);
  }
}
