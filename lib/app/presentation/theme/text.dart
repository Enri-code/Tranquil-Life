import 'package:flutter/material.dart';

abstract class MyTextData {
  static const josefinFamily = 'Josefin Sans';
  static TextTheme get textTheme => Typography.blackRedmond
      .copyWith(
        bodyText1: const TextStyle(height: 1.2, fontSize: 22),
        bodyText2: const TextStyle(height: 1.2, fontSize: 18),
        button: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      )
      .apply(fontFamily: josefinFamily);
}

abstract class MyTextStyles {
  static const underline = TextStyle(
    fontWeight: FontWeight.normal,
    decoration: TextDecoration.underline,
  );
}
