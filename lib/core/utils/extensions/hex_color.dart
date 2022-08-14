import 'package:flutter/painting.dart';

extension ToColorExt on String {
  Color toColor() {
    String colorString = replaceFirst('#', '').padLeft(8, 'ff');
    return Color(int.parse(colorString, radix: 16));
  }
}

extension FromColorValueExt on Color {
  String toHex() {
    var hex = value.toRadixString(16);
    if (hex.length > 6) hex = hex.substring(hex.length - 6);
    return '#$hex';
  }
}
