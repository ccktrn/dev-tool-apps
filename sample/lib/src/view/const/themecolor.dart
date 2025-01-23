import 'package:flutter/material.dart';

enum ThemeColor{
  red (Colors.red),
  orange (Colors.orange),
  yellow (Colors.yellow),
  green (Colors.green),
  cyan (Colors.cyan),
  blue (Colors.blue),
  purple (Colors.deepPurple),
  ;

  const ThemeColor(this.color);
  final Color color;
}
