import 'package:flutter/material.dart';

class AppColors {
  // Main Color Palette - Professional & Modern
  static const Color primary = Color(0xFF2196F3); // Blue
  static const Color secondary = Color(0xFF00BCD4); // Cyan
  static const Color accent = Color(0xFFFFC107); // Amber
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFE91E63); // Pink

  // Background Colors
  static const Color background = Color(0xFF0A0A0A); // Dark Background
  static const Color surface = Color(0xFF1A1A1A); // Card Background
  static const Color surfaceVariant = Color(0xFF2A2A2A); // Hover States

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFFB0B0B0); // Light Gray
  static const Color textTertiary = Color(0xFF707070); // Gray

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [
      Color(0xFF0F0F23),
      Color(0xFF1A1A2E),
      Color(0xFF16213E),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF1E1E1E),
      Color(0xFF2A2A2A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Social Media Colors
  static const Color github = Color(0xFF333333);
  static const Color linkedin = Color(0xFF0077B5);
  static const Color whatsapp = Color(0xFF25D366);
  static const Color email = Color(0xFFEA4335);
}

class AppTheme {
  static const double borderRadius = 12.0;
  static const double cardPadding = 24.0;
  static const double sectionPadding = 80.0;
  
  static const EdgeInsets mobilePadding = EdgeInsets.symmetric(horizontal: 20.0);
  static const EdgeInsets desktopPadding = EdgeInsets.symmetric(horizontal: 120.0);
}