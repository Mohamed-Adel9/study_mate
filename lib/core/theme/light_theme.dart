import 'package:flutter/material.dart';
import 'app_colors.dart';

class LightTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // 🌍 Scaffold
    scaffoldBackgroundColor: AppColors.lightBackground,

    // 🎨 Color Scheme (IMPORTANT)
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primary,
      error: AppColors.red,
      surface: AppColors.white,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.lightText,
      onError: AppColors.red,
    ),

    // 🧭 AppBar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.white,
      centerTitle: true,
    ),


    // 🔘 Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.all(18),
        alignment: Alignment.center,

      ),
    ),

    // 🔘 Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),

    // 🧾 Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    ),

    // 🧱 Cards
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    // 📱 Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
    ),

    // 📊 Divider
    dividerTheme: const DividerThemeData(color: AppColors.grey, thickness: 0.8),

    // 🔘 Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    //iconButton
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.lightBackground, // لون الأيقونة
        backgroundColor: Colors.transparent, // الخلفية
        iconSize: 24,
        padding: const EdgeInsets.all(10),

        // شكل الزر
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // 🔘 Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primary),
    ),

    // 🔄 Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.primary),
      trackColor: WidgetStatePropertyAll(
        AppColors.primary.withValues(alpha: 0.4),
      ),
    ),
  );
}