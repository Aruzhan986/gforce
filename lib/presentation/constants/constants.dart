import 'package:flutter/material.dart';

class PrimaryColors {
  static const Color Colorone = Color.fromARGB(255, 245, 149, 6);
  static const Color Colortwo = Color.fromARGB(255, 249, 249, 11);
  static const Color Colorthree = Color.fromARGB(255, 0, 0, 0);
  static const Color Colorfour = Color.fromARGB(255, 248, 246, 246);
  static const Color Colorfive = Color.fromARGB(255, 5, 134, 5);
  static const Color Colorsix = Color.fromARGB(255, 98, 98, 98);
  static const Color Colorseven = Color.fromARGB(255, 9, 135, 177);
  static const Color Coloreight = Color.fromARGB(255, 204, 6, 6);
  static const Color Colorten = Color.fromARGB(255, 169, 166, 166);
  static const Color Coloreleven = Color.fromARGB(255, 45, 222, 45);
  static const Color Coloretwoel = Color.fromARGB(255, 101, 72, 62);
}

class PrimaryGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 245, 149, 6),
      Color.fromARGB(255, 249, 249, 11)
    ],
  );
}
