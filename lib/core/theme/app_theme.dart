import 'package:flutter/material.dart';

class AppTheme {
  // Colores mostacita para restaurante - ¡Perfecto para comidas! 🌻
  static const Color primaryColor = Color(0xFFD4AC0D); // Mostacita dorado principal
  static const Color secondaryColor = Color(0xFFF7DC6F); // Mostacita claro
  static const Color accentColor = Color(0xFFB7950B); // Mostacita oscuro
  static const Color backgroundColor = Color(0xFFFEF9E7); // Crema suave
  static const Color surfaceColor = Color(0xFFFFFDF2); // Blanco cremoso
  static const Color errorColor = Color(0xFFE74C3C); // Rojo tomate
  
  // Colores adicionales para la experiencia gastronómica
  static const Color cardColor = Color(0xFFFDF6E3); // Pergamino suave
  static const Color dividerColor = Color(0xFFEAD7A3); // Mostacita muy claro
  
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      brightness: Brightness.light,
      onPrimary: Colors.white,
      onSecondary: Color(0xFF5D4E75),
      onSurface: Color(0xFF2C2C2C),
      outline: dividerColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 3,
      shadowColor: primaryColor.withOpacity(0.3),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: primaryColor.withOpacity(0.2),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        shadowColor: primaryColor.withOpacity(0.4),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(color: primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: TextStyle(color: primaryColor.withOpacity(0.8)),
      hintStyle: TextStyle(color: Colors.grey.shade600),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 6,
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
      ),
    ),
    
    iconTheme: IconThemeData(
      color: primaryColor,
      size: 24,
    ),
    
    dividerTheme: DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 16,
    ),
    
    listTileTheme: ListTileThemeData(
      tileColor: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );
}
