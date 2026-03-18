import 'package:flutter/material.dart';

class AppTheme {
  static const primaryNavy = Color(0xFF1E293B);
  static const accentBlue = Color(0xFF3B82F6);
  
  // Pure Black Dark Mode Colors
  static const darkSurface = Color(0xFF000000);
  static const darkBackground = Color(0xFF000000);

  static ThemeData get lightTheme {
    return _buildTheme(Brightness.light);
  }

  static ThemeData get darkTheme {
    return _buildTheme(Brightness.dark);
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: isDark ? Colors.white : primaryNavy,
        brightness: brightness,
        primary: isDark ? Colors.white : primaryNavy,
        surface: isDark ? darkSurface : Colors.white,
        onSurface: isDark ? Colors.white : primaryNavy,
        background: isDark ? darkBackground : const Color(0xFFF8FAFC),
        onBackground: isDark ? Colors.white : primaryNavy,
      ),
      scaffoldBackgroundColor: isDark ? darkBackground : const Color(0xFFF8FAFC),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: isDark ? Colors.white : primaryNavy,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
        ),
        iconTheme: IconThemeData(color: isDark ? Colors.white : primaryNavy),
      ),
      cardTheme: CardThemeData(
        color: isDark ? darkSurface : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isDark ? BorderSide(color: Colors.white.withOpacity(0.1), width: 1) : BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.white : primaryNavy,
          foregroundColor: isDark ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? Colors.black : Colors.white,
        indicatorColor: isDark ? Colors.white.withOpacity(0.1) : primaryNavy.withOpacity(0.1),
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(color: isDark ? Colors.white70 : primaryNavy, fontWeight: FontWeight.bold),
        ),
        iconTheme: MaterialStateProperty.all(
          IconThemeData(color: isDark ? Colors.white : primaryNavy),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF121212) : Colors.white, // Keeping input fields slightly visible
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        hintStyle: TextStyle(color: isDark ? Colors.white38 : Colors.grey),
      ),
    );
  }
}
