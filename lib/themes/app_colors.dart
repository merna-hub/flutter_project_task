import 'package:flutter/material.dart';

class AppColors {

  static Color background(bool isDark) => isDark ? Colors.black : const Color(0xFFF0E8FF);


  static Color primary(bool isDark) => isDark ? Colors.grey[900]! :  Colors.white;

  static Color card(bool isDark) => isDark ? Colors.grey[850]! : Colors.white;


  static Color cardAlt(bool isDark) => isDark ? Colors.grey[800]! : const Color(0xFFF0E8FF);


  static Color textPrimary(bool isDark) => isDark ? Colors.white : Colors.black;
  static Color textSecondary(bool isDark) => isDark ? Colors.white70 : Colors.grey;


  static Color button(bool isDark) => isDark ? Colors.tealAccent : Colors.blue;


  static Color icon(bool isDark) => isDark ? Colors.white : Colors.black;
}
