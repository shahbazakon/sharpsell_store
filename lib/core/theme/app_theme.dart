import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF3F51B5),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF3F51B5),
      primary: const Color(0xFF3F51B5),
      secondary: const Color(0xFFFF4081),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF3F51B5),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: Colors.white,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3F51B5),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF212121),
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Color(0xFF424242),
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF424242),
      ),
    ),
  );
}
