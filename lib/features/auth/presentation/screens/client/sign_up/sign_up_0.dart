import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_up/sign_up_1.dart';

class ClientSignUpScreen extends StatefulWidget {
  static const routeName = 'client_sign_up';

  const ClientSignUpScreen({Key? key}) : super(key: key);

  @override
  State<ClientSignUpScreen> createState() => _ClientSignUpScreenState();
}

class _ClientSignUpScreenState extends State<ClientSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final termsOfServiceGS = TapGestureRecognizer();
  final privacyPolicyGS = TapGestureRecognizer();

  @override
  void initState() {
    termsOfServiceGS.onTap = () {};
    privacyPolicyGS.onTap = () {};
    super.initState();
  }

  @override
  void dispose() {
    termsOfServiceGS.dispose();
    privacyPolicyGS.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign Up'),
      body: SafeArea(
        child: UnfocusWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 20),
                  child: Text(
                    'Register Account',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                const Text(
                  'Input your details',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Username or Email',
                          ),
                          validator: (_) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility_off),
                            ),
                          ),
                          validator: (_) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                          ),
                          validator: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ClientSignUp1Screen(),
                    ));
                  },
                  child: const Text('Next'),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text:
                        'By clicking "Next", you are indicating that you have read and agreed to the ',
                    children: [
                      TextSpan(
                        text: 'Terms of Service',
                        recognizer: termsOfServiceGS,
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        recognizer: privacyPolicyGS,
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
