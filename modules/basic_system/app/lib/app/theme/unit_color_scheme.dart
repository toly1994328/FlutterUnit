import 'package:flutter/material.dart';

const Color _lightCanvas = Color(0xFFF3F4F6);
const Color _lightSurface = Color(0xFFFFFFFF);
const Color _lightText = Color(0xFF191919);
const Color _lightSecondaryText = Color(0xFF60646B);
const Color _lightOutline = Color(0xFFC9CDD4);
const Color _lightDivider = Color(0xFFE5E6EB);
const Color _darkCanvas = Color(0xFF010201);
const Color _darkSurface = Color(0xFF181818);
const Color _darkRaisedSurface = Color(0xFF232323);
const Color _darkText = Color(0xFFD6D6D6);
const Color _darkSecondaryText = Color(0xFFA8ABB2);
const Color _darkOutline = Color(0xFF5A5A5A);
const Color _darkDivider = Color(0xFF2F2F2F);
const Color _error = Color(0xFFD93025);

/// 根据用户选择的激活色生成 FlutterUnit 黑白灰为主的颜色体系。
ColorScheme unitColorScheme({
  required Color activeColor,
  required Brightness brightness,
}) {
  final bool dark = brightness == Brightness.dark;
  final Color primary = _ensureVisibleActiveColor(activeColor, brightness);
  final Color surface = dark ? _darkSurface : _lightSurface;
  final Color canvas = dark ? _darkCanvas : _lightCanvas;
  final Color text = dark ? _darkText : _lightText;
  final Color secondaryText = dark ? _darkSecondaryText : _lightSecondaryText;
  final Color outline = dark ? _darkOutline : _lightOutline;
  final Color divider = dark ? _darkDivider : _lightDivider;
  final Color primaryContainer = Color.alphaBlend(
    primary.withValues(alpha: dark ? 0.22 : 0.10),
    surface,
  );
  final ColorScheme base = ColorScheme.fromSeed(
    seedColor: primary,
    brightness: brightness,
  );
  return base.copyWith(
    primary: primary,
    onPrimary: _foregroundFor(primary),
    primaryContainer: primaryContainer,
    onPrimaryContainer: text,
    secondary: primary,
    onSecondary: _foregroundFor(primary),
    secondaryContainer: primaryContainer,
    onSecondaryContainer: text,
    tertiary: primary,
    onTertiary: _foregroundFor(primary),
    surface: surface,
    onSurface: text,
    onSurfaceVariant: secondaryText,
    surfaceTint: Colors.transparent,
    surfaceContainerLowest: surface,
    surfaceContainerLow: surface,
    surfaceContainer: canvas,
    surfaceContainerHigh: dark ? _darkRaisedSurface : _lightCanvas,
    surfaceContainerHighest: dark ? _darkRaisedSurface : _lightCanvas,
    outline: outline,
    outlineVariant: divider,
    error: _error,
    onError: Colors.white,
    shadow: Colors.black,
    scrim: Colors.black,
    inversePrimary: primary,
  );
}

Color _ensureVisibleActiveColor(Color color, Brightness brightness) {
  if (brightness == Brightness.dark && color.computeLuminance() < 0.18) {
    return Color.alphaBlend(
      Colors.white.withValues(alpha: 0.45),
      color,
    );
  }
  return color;
}

Color _foregroundFor(Color background) {
  return background.computeLuminance() > 0.46 ? Colors.black : Colors.white;
}
