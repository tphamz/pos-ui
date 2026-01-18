import 'package:flutter/material.dart';

/// POS Theme matching the blueprint design
/// Converts oklch colors from the blueprint to Flutter ColorScheme
class POSTheme {
  // Dark theme colors (matching blueprint .dark)
  // oklch(0.12 0 0) -> approximately #1f1f1f
  static const Color darkBackground = Color(0xFF1F1F1F);
  // oklch(0.95 0 0) -> approximately #f2f2f2
  static const Color darkForeground = Color(0xFFF2F2F2);
  // oklch(0.16 0 0) -> approximately #292929
  static const Color darkCard = Color(0xFF292929);
  // oklch(0.6 0.18 250) -> blue/purple primary
  static const Color darkPrimary = Color(0xFF6366F1); // Indigo-500 as approximation
  // oklch(0.22 0 0) -> approximately #383838
  static const Color darkSecondary = Color(0xFF383838);
  // oklch(0.22 0 0) -> approximately #383838
  static const Color darkMuted = Color(0xFF383838);
  // oklch(0.65 0.15 165) -> teal/green accent
  static const Color darkAccent = Color(0xFF10B981); // Emerald-500 as approximation
  // oklch(0.55 0.22 25) -> red destructive
  static const Color darkDestructive = Color(0xFFEF4444); // Red-500 as approximation
  // oklch(0.25 0 0) -> approximately #404040
  static const Color darkBorder = Color(0xFF404040);
  // oklch(0.1 0 0) -> approximately #1a1a1a
  static const Color darkSidebar = Color(0xFF1A1A1A);
  // oklch(0.85 0 0) -> approximately #d9d9d9
  static const Color darkSidebarForeground = Color(0xFFD9D9D9);
  // oklch(0.18 0 0) -> approximately #2e2e2e
  static const Color darkSidebarAccent = Color(0xFF2E2E2E);
  // oklch(0.22 0 0) -> approximately #383838
  static const Color darkSidebarBorder = Color(0xFF383838);
  // oklch(0.65 0.15 165) -> success green
  static const Color darkSuccess = Color(0xFF10B981);
  // oklch(0.8 0.15 85) -> warning yellow
  static const Color darkWarning = Color(0xFFF59E0B); // Amber-500 as approximation

  // Light theme colors (matching blueprint :root)
  // oklch(0.98 0 0) -> approximately #fafafa
  static const Color lightBackground = Color(0xFFFAFAFA);
  // oklch(0.15 0 0) -> approximately #262626
  static const Color lightForeground = Color(0xFF262626);
  // oklch(1 0 0) -> white
  static const Color lightCard = Colors.white;
  // oklch(0.55 0.18 250) -> blue/purple primary
  static const Color lightPrimary = Color(0xFF6366F1);
  // oklch(0.95 0 0) -> approximately #f2f2f2
  static const Color lightSecondary = Color(0xFFF2F2F2);
  // oklch(0.95 0 0) -> approximately #f2f2f2
  static const Color lightMuted = Color(0xFFF2F2F2);
  // oklch(0.65 0.15 165) -> teal/green accent
  static const Color lightAccent = Color(0xFF10B981);
  // oklch(0.55 0.22 25) -> red destructive
  static const Color lightDestructive = Color(0xFFEF4444);
  // oklch(0.9 0 0) -> approximately #e6e6e6
  static const Color lightBorder = Color(0xFFE6E6E6);
  // oklch(0.12 0 0) -> approximately #1f1f1f
  static const Color lightSidebar = Color(0xFF1F1F1F);
  // oklch(0.85 0 0) -> approximately #d9d9d9
  static const Color lightSidebarForeground = Color(0xFFD9D9D9);
  // oklch(0.2 0 0) -> approximately #333333
  static const Color lightSidebarAccent = Color(0xFF333333);
  // oklch(0.25 0 0) -> approximately #404040
  static const Color lightSidebarBorder = Color(0xFF404040);
  // oklch(0.65 0.15 165) -> success green
  static const Color lightSuccess = Color(0xFF10B981);
  // oklch(0.8 0.15 85) -> warning yellow
  static const Color lightWarning = Color(0xFFF59E0B);

  /// Get dark theme matching the blueprint
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: darkPrimary,
        onPrimary: Colors.white,
        secondary: darkSecondary,
        onSecondary: darkForeground,
        surface: darkCard,
        onSurface: darkForeground,
        background: darkBackground,
        onBackground: darkForeground,
        error: darkDestructive,
        onError: Colors.white,
        outline: darkBorder,
      ),
      scaffoldBackgroundColor: darkBackground,
      cardTheme: CardThemeData(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: darkBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: darkBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: darkPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkForeground,
          side: BorderSide(color: darkBorder),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  /// Get light theme matching the blueprint
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: lightPrimary,
        onPrimary: Colors.white,
        secondary: lightSecondary,
        onSecondary: lightForeground,
        surface: lightCard,
        onSurface: lightForeground,
        background: lightBackground,
        onBackground: lightForeground,
        error: lightDestructive,
        onError: Colors.white,
        outline: lightBorder,
      ),
      scaffoldBackgroundColor: lightBackground,
      cardTheme: CardThemeData(
        color: lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: lightBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: lightBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: lightPrimary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightForeground,
          side: BorderSide(color: lightBorder),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  // Sidebar colors (same for both themes in blueprint)
  static Color getSidebarColor(bool isDark) => isDark ? darkSidebar : lightSidebar;
  static Color getSidebarForegroundColor(bool isDark) => isDark ? darkSidebarForeground : lightSidebarForeground;
  static Color getSidebarAccentColor(bool isDark) => isDark ? darkSidebarAccent : lightSidebarAccent;
  static Color getSidebarBorderColor(bool isDark) => isDark ? darkSidebarBorder : lightSidebarBorder;
  static Color getSuccessColor(bool isDark) => isDark ? darkSuccess : lightSuccess;
  static Color getWarningColor(bool isDark) => isDark ? darkWarning : lightWarning;
}
