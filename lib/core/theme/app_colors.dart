import 'package:flutter/material.dart';

/// Global color palette for GeoSurvey Pro
/// Use these colors throughout the app for consistency
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors - Teal/Green for GIS/Mapping feel
  static const Color primary = Color(0xFF00897B); // Teal 600
  static const Color primaryDark = Color(0xFF00695C); // Teal 800
  static const Color primaryLight = Color(0xFF4DB6AC); // Teal 300

  // Secondary Colors
  static const Color secondary = Color(0xFF43A047); // Green 600
  static const Color secondaryDark = Color(0xFF2E7D32); // Green 800
  static const Color secondaryLight = Color(0xFF66BB6A); // Green 400

  // Accent Colors
  static const Color accent = Color(0xFFFF6F00); // Orange 900
  static const Color accentLight = Color(0xFFFFB74D); // Orange 300

  // Background Colors
  static const Color background = Color(0xFFF5F5F5); // Grey 100
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceDark = Color(0xFF121212); // Dark surface

  // Text Colors
  static const Color textPrimary = Color(0xFF212121); // Grey 900
  static const Color textSecondary = Color(0xFF757575); // Grey 600
  static const Color textHint = Color(0xFFBDBDBD); // Grey 400
  static const Color textOnPrimary = Color(0xFFFFFFFF); // White

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green 500
  static const Color warning = Color(0xFFFFC107); // Amber 500
  static const Color error = Color(0xFFF44336); // Red 500
  static const Color info = Color(0xFF2196F3); // Blue 500

  // Map-specific Colors
  static const Color polygonFill = Color(
    0x4000897B,
  ); // Primary with 25% opacity
  static const Color polygonStroke = Color(0xFF00897B); // Primary
  static const Color markerColor = Color(0xFFFF6F00); // Accent
  static const Color selectedMarker = Color(0xFFF44336); // Error/Red

  // Neutral Colors
  static const Color divider = Color(0xFFE0E0E0); // Grey 300
  static const Color disabled = Color(0xFFBDBDBD); // Grey 400
  static const Color shadow = Color(0x1F000000); // Black with 12% opacity
}
