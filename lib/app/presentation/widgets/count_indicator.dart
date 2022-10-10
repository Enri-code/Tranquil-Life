import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

class CountIndicator extends StatelessWidget {
  const CountIndicator(this.amount, {Key? key}) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(8, -2),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: ColorPalette.red,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.2),
        ),
        child: Center(
          child: Text(
            () {
              final amt = amount.toString();
              if (amt.length > 2) return '99+';
              return amt;
            }(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
