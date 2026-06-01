import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFC9C9C9);
  static const Color orange = Color(0xFFEA6B23);
  static const Color grey = Color(0xFF6C6C6C);
  static const Color backgroundColor = Color(0xFFfffbf7);
  static const Color lightRedBackground = Color(0x1A383CFF); // #FF383C1A - wait, #FF383C1A is 1A alpha, 38 R, 3C G, FF B? No, usually hex is AARRGGBB.
  // User said background: #FF383C1A; but also 1A as alpha.
  // 1A in hex is 26 decimal.
  // Let's assume #383C1A is the color and 1A is the alpha? No, that looks like dark green.
  // Image shows light pinkish red. #FF383C with 1A alpha.
  static const Color deleteRed = Color(0xFFFF0000);
  static const Color deleteBg = Color(0x1AFF383C);
  static const Color lightGreyBg = Color(0xFFF7F7F7);
  static const Color saveGreenBg = Color(0xFFDBF1E5);
  static const Color saveGreenText = Color(0xFF04BC00);
  static const Color transactionBg = Color(0xFFE6ECF4);
  static const Color saveButtonGreen = Color(0xFF28A745);
  static const Color orangeGradientStart = Color(0xFFFFAE81);
  static const Color orangeGradientEnd = Color(0xFFEA6B23);
  static const Color lightGrey = Color(0xFFC7C7C7);
  static const Color selectedItemBg = Color(0xFFEAFAEC);
  static const Color checkboxGreen = Color(0xFF27C840);
  static const Color selectedProductBg = Color(0xFF40599B);
  static const Color orangeTitle = Color(0xFFEA6B23);
  static const Color orangeLite=Color(0xFFfcf0e9);
}

