import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';

class ThemeBrightnessIcon extends StatelessWidget {
  const ThemeBrightnessIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isBright = Theme.of(context).brightness == Brightness.light;
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: isBright ? Colors.white : Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(
        TranquilIcons.bright,
        size: 22,
        color: isBright ? Colors.black : Colors.white,
      ),
    );
  }
}
