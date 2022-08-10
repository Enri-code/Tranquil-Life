import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/buttons.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';

abstract class MyThemeData {
  static final theme = ThemeData.from(
    colorScheme: const ColorScheme.light(primary: ColorPalette.primary),
    textTheme: MyTextData.textTheme,
  ).copyWith(
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    textButtonTheme: MyButtonTheme.textButtonTheme,
    elevatedButtonTheme: MyButtonTheme.elevatedButtonTheme,
    outlinedButtonTheme: MyButtonTheme.outlinedButtonTheme,
    inputDecorationTheme: MyButtonTheme.inputDecorationTheme,
  );
}
