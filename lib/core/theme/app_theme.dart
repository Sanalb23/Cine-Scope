import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static TextTheme textTheme = GoogleFonts.robotoTextTheme();

  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.deepBlue,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme,
  );

  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.deepBlue,
    scaffoldBackground: const Color(0xFF0A192F),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      cardBackgroundSchemeColor: .secondaryContainer,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    textTheme: textTheme,
  );
}
