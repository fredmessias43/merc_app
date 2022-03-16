import 'package:flutter/material.dart';

Color getColor(index) {
  var colors = Colors.accents;

  int color = index;

  double calc = color / colors.length;

  color = color - (calc.floor() * colors.length);

  return colors[color];
}
