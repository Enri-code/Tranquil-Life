import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const primary = MaterialColor(
    0xff43A95D,
    {
      500: Color(0xff43A95D),
      800: Color(0xff2D713E),
    },
  );
  static const secondary = MaterialColor(
    0xff04557D,
    {
      300: Color(0xff056B9C),
      500: Color(0xff04557D),
    },
  );
}
