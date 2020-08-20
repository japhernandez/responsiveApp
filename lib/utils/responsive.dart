import 'dart:math' as match;
import 'package:flutter/material.dart';

class ResponsiveDesign {
  double width, height, inch;

  ResponsiveDesign(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
    // Teorema de pitagoras
    // c2 = a2 + b2 => c2 = sqrt(a2 + b2)
    inch = match.sqrt(match.pow(width, 2) + match.pow(height, 2));
  }

  // Ancho
  double widthPercent(double percent) {
    return width * percent / 100;
  }

  // Alto
  double heightPercent(double percent) {
    return height * percent / 100;
  }

  // Diagonal
  double inchPercent(double percent) {
    return inch * percent / 100;
  }
}
