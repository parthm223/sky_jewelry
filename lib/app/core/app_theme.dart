import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Color Palette
  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color darkGold = Color(0xFFB8860B);
  static const Color lightGold = Color(0xFFF5E6A3);
  static const Color premiumBlack = Color(0xFF1A1A1A);
  static const Color softBlack = Color(0xFF2D2D2D);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFAFA);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color mediumGrey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF424242);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGold,
        brightness: Brightness.light,
        primary: primaryGold,
        secondary: premiumBlack,
        surface: pureWhite,
        background: offWhite,
      ),
      textTheme: GoogleFonts.playfairDisplayTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: premiumBlack,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: premiumBlack,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: premiumBlack,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: premiumBlack,
        ),
        bodyLarge: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: premiumBlack,
        ),
        bodyMedium: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkGrey,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: pureWhite,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: premiumBlack,
        ),
        iconTheme: const IconThemeData(color: premiumBlack),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: premiumBlack,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: pureWhite,
        elevation: 2,
        shadowColor: premiumBlack.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: mediumGrey,
        thickness: 0.6,
        space: 24,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lightGrey,
        disabledColor: lightGrey.withOpacity(0.7),
        selectedColor: primaryGold.withOpacity(0.15),
        secondarySelectedColor: primaryGold.withOpacity(0.15),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: GoogleFonts.lato(
          color: premiumBlack,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: GoogleFonts.lato(
          color: premiumBlack,
          fontWeight: FontWeight.w600,
        ),
        brightness: Brightness.light,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: pureWhite,
          foregroundColor: premiumBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
