import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:cine_scope/features/home/presentation/landscape_home_body.dart';
import 'package:cine_scope/features/home/presentation/portrait_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;

    return isLandscape ? const LandscapeHomeBody() : const PortraitHomeScreen();
  }
}
