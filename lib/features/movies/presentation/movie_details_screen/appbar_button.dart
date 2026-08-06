import 'package:cine_scope/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.text,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return text != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            label: Text(text!, style: context.textTheme.titleSmall),
            icon: Icon(icon, color: context.colors.onSurface),
          )
        : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: context.colors.surface,
            ),
            icon: Icon(icon),
            onPressed: onPressed,
          );
  }
}
