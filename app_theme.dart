import 'package:flutter/material.dart';
 //Palette//
class AppColors {
  AppColors._();
 
  static const primary = Color(0xFFB8AAAA); // buttons, active states, app bar
  static const secondary = Color(0xFF847C7C); // highlights, secondary actions
  static const backgroundDark = Color(0xFF454343); // screen background (dark)
  static const backgroundLight = Color(0xFFDDDDDD); // from the light-mode mockup
  static const surface = Color(0xFF847C7C); // cards, sheets, dialogs
  static const onColor = Color(0xFFFFFFFF); // text/icons on primary/surface
  static const sun = Color(0xFFE08A4B); // light-mode sun icon (from mockup)
  // Error: N/A in the design system yet.
}
 
/// SPACING ///
class AppSpacing {
  AppSpacing._();
 
  static const double xs = 4; // base unit
  static const double sm = 8;
  static const double md = 16; // screen edge padding
  static const double cardGap = 12; // gap between timer cards
  static const double lg = 24; // gap between sections
}
 
/// TYPE SCALE ///
class AppTextTheme {
  AppTextTheme._();
 
  static const String? fontFamily = null;
 
  static const headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.onColor,
  );
  static const titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: AppColors.onColor,
  );
  static const bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.onColor,
  );
  static const labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.onColor,
  );
 
  static const textTheme = TextTheme(
    headlineSmall: headlineSmall,
    titleMedium: titleMedium,
    bodyMedium: bodyMedium,
    labelSmall: labelSmall,
  );
}
 
/// THEMES ///
enum AppThemeVariant { 
 dark, 
 light, 
 sunset 
 }

class _VariantColors {
  final Brightness brightness;
  final Color background;
  final Color primary;
  final Color secondary;
  final Color surface;
 
  const _VariantColors({
    required this.brightness,
    required this.background,
    required this.primary,
    required this.secondary,
    required this.surface,
  });
 
class AppTheme {
  AppTheme._();
 
  static ThemeData get dark => _build(AppColors.backgroundDark, Brightness.dark);
  static ThemeData get light => _build(AppColors.backgroundLight, Brightness.light);
 
  static ThemeData _build(Color background, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: AppColors.onColor,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onColor,
        surface: AppColors.surface,
        onSurface: AppColors.onColor,
        // Design system has no error color yet; placeholder so Flutter is happy.
        error: const Color(0xFFB3261E),
        onError: AppColors.onColor,
      ),
      textTheme: AppTextTheme.textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onColor,
        elevation: 0,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(const Color(0xFFE6DADA)),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? const Color(0xFF5F5858)
              : AppColors.secondary,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
