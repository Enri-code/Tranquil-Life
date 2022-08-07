import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/background.png', fit: BoxFit.cover),
          Align(
            alignment: const Alignment(0, -0.3),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
          ),
          const Positioned(
            bottom: 64,
            left: 50,
            right: 50,
            child: Center(
              child: Text(
                'A safe space to talk and feel without judgement.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 21, color: Colors.white, height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
