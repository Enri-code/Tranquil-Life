import 'package:flutter/material.dart';

abstract class MyTextData {
  static const josefinFamily = 'Josefin Sans';
  static final textTheme = Typography.blackRedmond
      .copyWith(
        bodyText1: const TextStyle(height: 1.1, fontSize: 16.5),
        bodyText2: const TextStyle(height: 1.1, fontSize: 14.5),
        button: const TextStyle(
          fontSize: 18,
          wordSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      )
      .apply(fontFamily: josefinFamily);
}
