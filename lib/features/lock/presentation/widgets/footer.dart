import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key, required this.controller}) : super(key: key);

  final InputController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TextButton(
        style: TextButton.styleFrom(primary: ColorPalette.green),
        onPressed: () => controller.unsetConfirmed(),
        child: const Text('RESET', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
