import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/buttons.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';

class LightThemeData {
  final Color primaryColor;
  LightThemeData(this.primaryColor)
      : buttonTheme = MyButtonTheme(primaryColor: primaryColor) {
    theme = ThemeData.from(
      colorScheme: ColorScheme.light(primary: primaryColor),
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
      textButtonTheme: buttonTheme.textButtonTheme,
      elevatedButtonTheme: buttonTheme.elevatedButtonTheme,
      outlinedButtonTheme: buttonTheme.outlinedButtonTheme,
      inputDecorationTheme: MyButtonTheme.inputDecorationTheme,
    );
  }
  final MyButtonTheme buttonTheme;
  late final ThemeData theme;
}
