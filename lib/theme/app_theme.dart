import 'package:flutter/material.dart';
import 'package:portfolio_app/theme/app_colors.dart';

class AppTheme {
  static final TextTheme _textTheme = TextTheme(
    displayLarge: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    displayMedium: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    displaySmall: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    titleLarge: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    titleSmall: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    bodySmall: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    labelLarge: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    labelMedium: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
    labelSmall: const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.teal,
      primary: AppColors.teal,
      secondary: AppColors.mint,
      tertiary: AppColors.yellow,
      background: Colors.white,
      surface: Colors.white,
      primaryContainer: AppColors.mint.withOpacity(0.7),
      secondaryContainer: AppColors.yellow.withOpacity(0.7),
      tertiaryContainer: AppColors.lightGray.withOpacity(0.7),
    ),
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.teal,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.teal,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.mint.withOpacity(0.7),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.black87,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.teal,
      unselectedLabelColor: AppColors.darkGray,
      indicatorColor: AppColors.teal,
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.teal,
      primary: AppColors.teal,
      secondary: AppColors.mint,
      tertiary: AppColors.yellow,
      brightness: Brightness.dark,
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E),
      primaryContainer: AppColors.teal.withOpacity(0.2),
      secondaryContainer: AppColors.mint.withOpacity(0.2),
      tertiaryContainer: AppColors.yellow.withOpacity(0.2),
    ),
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkGray,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.teal,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.mint,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.teal.withOpacity(0.3),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white70,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.mint,
      unselectedLabelColor: AppColors.lightGray,
      indicatorColor: AppColors.mint,
      indicatorSize: TabBarIndicatorSize.tab,
    ),
  );
}
