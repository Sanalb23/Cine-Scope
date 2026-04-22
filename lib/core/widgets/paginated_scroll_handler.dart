import 'package:flutter/material.dart';

class PaginatedScrollHandler extends StatefulWidget {
  final Future<void> Function() onFetchMore;
  final Widget Function(BuildContext context, bool isFetchingMore) builder;

  const PaginatedScrollHandler({
    super.key,
    required this.onFetchMore,
    required this.builder,
  });

  @override
  State<PaginatedScrollHandler> createState() => _PaginatedScrollHandlerState();
}

class _PaginatedScrollHandlerState extends State<PaginatedScrollHandler> {
  bool _isFetchingMore = false;

  void _fetchMore() {
    if (_isFetchingMore) return;

    setState(() => _isFetchingMore = true);

    widget.onFetchMore().then((_) {
      if (mounted) setState(() => _isFetchingMore = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent * 0.9) {
          _fetchMore();
        }
        return false;
      },
      child: widget.builder(context, _isFetchingMore),
    );
  }
}
