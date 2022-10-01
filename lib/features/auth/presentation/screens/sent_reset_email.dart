import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';

///Arguments should be email address
class SentPasswordResetEmailScreen extends StatelessWidget {
  static const routeName = 'sent_password_reset';
  const SentPasswordResetEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Check Your Inbox',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              Text(
                'A password reset link has been sent to ${ModalRoute.of(context)!.settings.arguments}.',
                style: const TextStyle(fontSize: 20, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.routeName,
                    (_) => false,
                  );
                },
                child: const Text(
                  'Back to the log in page',
                  style: MyTextStyles.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
