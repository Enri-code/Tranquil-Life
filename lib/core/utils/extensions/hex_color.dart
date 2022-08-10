import 'package:flutter/painting.dart';

extension HexColorExt on String {
  Color toColor() {
    String colorString;
    colorString = this;
    if (colorString.contains('#')) colorString = replaceFirst('#', '');
    if (colorString.length == 6) colorString = 'ff$colorString';
    return Color(int.parse('0x$colorString'));
  }
}
