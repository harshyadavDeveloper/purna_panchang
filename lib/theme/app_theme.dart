import 'package:flutter/material.dart';

class AppTheme {
  static const saffron      = Color(0xFFFF6F00);
  static const saffronLight = Color(0xFFFFE0B2);
  static const cream        = Color(0xFFFFF8E1);
  static const darkBrown    = Color(0xFF4E342E);
  static const gold         = Color(0xFFFFB300);
  static const redTilak     = Color(0xFFB71C1C);

  // Font helpers — use these everywhere instead of GoogleFonts
  static TextStyle poppins({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = darkBrown,
    double? height,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontStyle: fontStyle,
    );
  }

  static TextStyle playfair({
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.bold,
    Color color = darkBrown,
  }) {
    return TextStyle(
      fontFamily: 'PlayfairDisplay',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: saffron,
        primary: saffron,
        surface: cream,
      ),
      scaffoldBackgroundColor: cream,
      fontFamily: 'Poppins',
      textTheme: TextTheme(
        displayLarge: playfair(fontSize: 32),
        headlineMedium: playfair(fontSize: 20),
        titleLarge: poppins(fontSize: 16, fontWeight: FontWeight.w600),
        bodyMedium: poppins(fontSize: 14),
        bodySmall: poppins(fontSize: 12, color: Colors.grey),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: saffron,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: playfair(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: saffron,
        unselectedItemColor: Colors.grey,
        elevation: 12,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}