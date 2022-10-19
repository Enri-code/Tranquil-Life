import 'package:flutter/material.dart';

abstract class MyTextData {
  static const josefinFamily = 'Josefin Sans';
  static TextTheme get textTheme => Typography.blackRedmond
      .copyWith(
        bodyLarge: const TextStyle(height: 1.2, fontSize: 22, wordSpacing: 1.3),
        bodyMedium:
            const TextStyle(height: 1.2, fontSize: 16.5, wordSpacing: 1.3),
        labelLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
      .apply(fontFamily: josefinFamily);
}

abstract class MyTextStyles {
  static const underline = TextStyle(
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
  );
}
