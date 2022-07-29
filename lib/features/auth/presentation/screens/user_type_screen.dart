import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_in/sign_in.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_up/sign_up_0.dart';

class UserTypeSreen extends StatelessWidget {
  static const routeName = 'user_type_screen';

  const UserTypeSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/mountains_bg.png'),
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.88,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: ColorPalette.secondary,
                            side: const BorderSide(
                              width: 1.8,
                              color: ColorPalette.secondary,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Consultant'),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(ClientSignUpScreen.routeName),
                          child: const Text('Client'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DefaultTextStyle(
                      style: const TextStyle(fontSize: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(SignInScreen.routeName);
                            },
                            child: const Text('Log in'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
