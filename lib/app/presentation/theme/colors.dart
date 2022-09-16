import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const green = MaterialColor(
    0xff43A95D,
    {200: Color(0xffD9EEDF), 500: Color(0xff43A95D), 800: Color(0xff2D713E)},
  );
  static const blue = MaterialColor(
    0xff056B9C,
    {500: Color(0xff056B9C), 800: Color(0xff04557D)},
  );
  static const yellow = MaterialColor(0xFFEDC24D, {
    // 300: Color(0xFFFFCF2B),
    500: Color(0xFFEDC24D),
  });
  static const red = MaterialColor(0xFFEF5656, {
    300: Color.fromARGB(255, 255, 114, 114),
    500: Color(0xFFEF5656),
  });
}
