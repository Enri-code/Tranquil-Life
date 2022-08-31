import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';

abstract class MyButtonTheme {
  static final textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(primary: ColorPalette.green[800]),
  );
  static final elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    fixedSize: const Size(380, 56),
    onPrimary: Colors.white,
    textStyle: const TextStyle(
      fontFamily: MyTextData.josefinFamily,
      fontWeight: FontWeight.normal,
      fontSize: 18,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));

  static final outlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    fixedSize: const Size(380, 56),
    padding: const EdgeInsets.all(12),
    side: const BorderSide(width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ));

  static const inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xffF1F1F1),
    hintStyle: TextStyle(color: Colors.grey, height: 1.2),
    errorStyle: TextStyle(fontSize: 14, color: Color.fromARGB(255, 241, 0, 0)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color.fromARGB(255, 226, 224, 224)),
    ),
    contentPadding: EdgeInsets.all(24),
  );
}
