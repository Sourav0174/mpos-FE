import 'package:flutter/material.dart';

class AppColors {
  // Light Mode Colors
  static const Color primaryLight = Color(0xFF0066FF); // Crisp, modern blue
  static const Color backgroundLight = Color(0xFFF7F9FC); // Off-white for less eye strain
  static const Color surfaceLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF111827); // Very dark gray, not pure black
  static const Color textSecondaryLight = Color(0xFF6B7280);

  // Dark Mode Colors
  static const Color primaryDark = Color(0xFF3385FF); // Slightly brighter blue for contrast
  static const Color backgroundDark = Color(0xFF111827); // Deep gray, modern dark mode
  static const Color surfaceDark = Color(0xFF1F2937); // Lighter gray for elevated surfaces
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Off-white text
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // Universal Status Colors (Great for POS context)
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}
