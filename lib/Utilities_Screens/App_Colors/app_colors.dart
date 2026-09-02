import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1A1A2E); // Dark Navy
  static const Color secondary = Color(0xFFE94560); // Vibrant Red/Pink
  static const Color tertiary = Color(0xFFF5A623); // Golden Orange

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFFE94560),
    Color(0xFFF5A623),
  ];


  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF121212)
        : const Color(0xFFF8F9FA);
  }

  static Color cardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E2E)
        : Colors.white;
  }

  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : const Color(0xFF1A1A2E);
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[400]!
        : const Color(0xFF6B7280);
  }
}
