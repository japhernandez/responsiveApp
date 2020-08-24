import 'package:flutter/material.dart';
import 'dart:math' as match;

class ResponsiveDesignExtra {
  double width, height, inch;

  ResponsiveDesignExtra(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orient = MediaQuery.of(context).orientation;

    if (orient == Orientation.portrait) {
      width = size.width;
      height = size.height;
    } else {
      width = size.height;
      height = size.width;
    }

    inch = match.sqrt(match.pow(width, 2) + match.pow(height, 2));
  }

  // Ancho
  double widthMultiplier(double pixel) {
    double tempPercent = (pixel * 100.0) / 375.0;
    return (width * tempPercent) / 100;
  }

  // Alto
  double heightMultiplier(double pixel) {
    double tempPercent = (pixel * 100.0) / 667.0;
    return (height * tempPercent) / 100;
  }

  // Imagen
  double imageMultiplier(double pixel) {
    double tempPercent = (pixel * 100.0) / 375.0;
    return (width * tempPercent) / 100;
  }

  // Diagonal
  double inchPercent(double percent) {
    return inch * percent / 100;
  }
}
