import 'package:cine_scope/core/theme/data/app_theme.dart';
import 'package:flutter/material.dart';

class ScrollToTopButton extends StatefulWidget {
  const ScrollToTopButton({super.key, required this.builder});

  final Widget Function(BuildContext context, ScrollController controller)
  builder;

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.axis == Axis.vertical) {
              if (notification.metrics.pixels > 400 && !_showButton) {
                setState(() => _showButton = true);
              } else if (notification.metrics.pixels <= 400 && _showButton) {
                setState(() => _showButton = false);
              }
            }
            return false;
          },
          child: Stack(
            children: [
              widget.builder(context, _scrollController),
              if (_showButton)
                Positioned(
                  bottom: AppSpacing.xl,
                  right: AppSpacing.lg,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: const Icon(Icons.keyboard_arrow_up_rounded),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
