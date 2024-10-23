import 'package:flutter/material.dart';

// Light Theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xFFF6F6F6),
    surfaceContainerLowest: Color(0xFFFFFFFF),
    onSurface: Color(0xFF152945),
    primary: Color(0xFF152945),
    onPrimary: Color(0xFFF6F6F6),
  ),
);

// Dark Theme
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    surface: Color(0xFF161E29),
    surfaceContainerLowest: Color(0xFF0A0F12),
    onSurface: Color(0xFFF6F6F6),
    primary: Color(0xFF152945),
    onPrimary: Color(0xFFF6F6F6),
  ),
);
