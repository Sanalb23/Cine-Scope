import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(backgroundColor: context.colors.surface),
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
