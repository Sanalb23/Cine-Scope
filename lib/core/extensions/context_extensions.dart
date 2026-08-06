import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenDiagonal => sqrt(pow(screenWidth, 2) + pow(screenHeight, 2));

  bool get isWideScreen => screenWidth > 600;
  bool get isSmallScreen => screenWidth <= 600;
  bool get isMediumScreen => screenWidth > 600 && screenWidth <= 1024;
  bool get isLargeScreen => screenWidth > 1024;

  bool get isLandscape => screenWidth > screenHeight;
  bool get isPortrait => screenHeight > screenWidth;
}
