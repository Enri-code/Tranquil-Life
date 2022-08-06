import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

abstract class MyThemeData {
  static final _myTextTheme =
      Typography.blackRedmond /* .apply(fontFamily: 'Lucette') */ .copyWith(
    bodyText1: const TextStyle(fontSize: 16.5, height: 1.02),
    bodyText2: const TextStyle(fontSize: 14.5, height: 1.02),
    button: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      wordSpacing: 1,
    ),
  );

  static final theme = ThemeData.from(
    textTheme: _myTextTheme,
    colorScheme: const ColorScheme.light(
      primary: ColorPalette.primary,
    ),
  ).copyWith(
    useMaterial3: true,
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //iconTheme: const IconThemeData(color: ColorPalette.primary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: ColorPalette.primary[800]),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      fixedSize: const Size(380, 60),
      primary: ColorPalette.primary[800],
      onPrimary: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    )),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      fixedSize: const Size(380, 60),
      padding: const EdgeInsets.all(12),
      side: const BorderSide(width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    )),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xffF1F1F1),
      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color.fromARGB(255, 226, 224, 224)),
      ),
      contentPadding: EdgeInsets.all(24),
    ),
  );
}
