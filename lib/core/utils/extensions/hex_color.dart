import 'package:flutter/painting.dart';

extension ToColorExt on String {
  Color toColor() {
    String colorString;
    colorString = this;
    if (colorString.contains('#')) colorString = replaceFirst('#', '');
    if (colorString.length == 6) colorString = 'ff$colorString';
    return Color(int.parse('0x$colorString'));
  }
}

extension FromColorValueExt on int {
  String toHex() => '#${toString().substring(4)}';
}
