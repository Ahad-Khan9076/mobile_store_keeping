import 'package:flutter/material.dart';

// Define a class to hold the theme constants
class AppTheme {
  // Color Palette
  static const Color primaryColor = Color(0xFF176F75);
  static const Color secondaryColor = Color(0xFF7DA7AA);
  static const Color accentColor = Color(0xFFFFC656);
  static const Color errorColor = Color(0xFFF16063);
  static const Color lightColor = Color(0xFFC7FBFF);
  static const Color darkColor = Color(0xFF1B1F26);
  static const Color dividerColor = Color(0xFFD9D9D9);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Text Styles
  static const TextStyle header1 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w800, // Extra Bold
    fontFamily: 'Open Sans',
  );

  static const TextStyle header2 = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600, // Semi Bold
    fontFamily: 'Open Sans',
  );

  static const TextStyle header3 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Semi Bold
    fontFamily: 'Open Sans',
  );

  static const TextStyle header4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold, // Bold
    fontFamily: 'Open Sans',
    color: Colors.white
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Open Sans',
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    fontFamily: 'Open Sans',
  );
}
