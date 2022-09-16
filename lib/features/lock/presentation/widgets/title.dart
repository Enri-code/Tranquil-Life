import 'package:flutter/material.dart';

class LockTitleWidget extends StatelessWidget {
  const LockTitleWidget({Key? key, required this.isPinSetup}) : super(key: key);
  final bool isPinSetup;

  @override
  Widget build(BuildContext context) {
    if (isPinSetup) {
      return const Text('Please insert a new pin');
    } else {
      return const Text('Please insert your pin');
    }
  }
}
