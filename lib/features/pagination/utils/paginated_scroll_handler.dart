import 'package:flutter/material.dart';

class PaginatedScrollHandler extends StatelessWidget {
  const PaginatedScrollHandler({
    super.key,
    required this.fetchCallback,
    required this.retryCallback,
    required this.child,
  });
  final VoidCallback fetchCallback;
  final VoidCallback retryCallback;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent * 0.6) {
          fetchCallback();
        }

        return false;
      },
      child: child,
    );
  }
}
