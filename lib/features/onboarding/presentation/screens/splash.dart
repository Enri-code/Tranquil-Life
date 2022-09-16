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
            alignment: const Alignment(0, -0.2),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 48,
            child: Center(
              child: Text(
                'A safe space to talk and feel without judgement.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
