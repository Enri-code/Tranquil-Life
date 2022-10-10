import 'package:flutter/material.dart';

abstract class MyTextData {
  static const josefinFamily = 'Josefin Sans';
  static TextTheme get textTheme => Typography.blackRedmond
      .copyWith(
        bodyText1: const TextStyle(height: 1.2, fontSize: 22, wordSpacing: 1.3),
        bodyText2:
            const TextStyle(height: 1.2, fontSize: 16.5, wordSpacing: 1.3),
        button: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      )
      .apply(fontFamily: josefinFamily);
}

abstract class MyTextStyles {
  static const underline = TextStyle(
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
  );
}
