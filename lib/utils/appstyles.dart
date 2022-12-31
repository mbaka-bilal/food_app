import 'package:flutter/material.dart';

class AppColors {
  static const black = Color(0xFF1B1B1B);
  static const white = Color(0xFFFFFFFF);
  static const alabaster = Color(0xFFEDEADE);
  static const grey = Color(0xFF767676);
  static const greyLines = Color(0xFF252525);
  static const green = Color(0xFF22C676);
  static const darkGreen = Color(0xFF013220);
}

class TextStyles {
  static const normal = fw400;
  static const semiBold = fw600;

  static TextStyle fw400(double size, Color color, [String? fontFamily]) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle fw600(double size, Color color, [String? fontFamily]) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }
}
