import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_up/sign_up_2.dart';

class ClientSignUp1Screen extends StatefulWidget {
  const ClientSignUp1Screen({Key? key}) : super(key: key);

  @override
  State<ClientSignUp1Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<ClientSignUp1Screen> {
  final _formKey = GlobalKey<FormState>();

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
                  'Complete your profile',
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
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'First Name',
                          ),
                          validator: (_) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Last Name',
                          ),
                          validator: (_) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Username',
                          ),
                          validator: (_) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: GestureDetector(
                          onTap: () {
                            print('dob tapped');
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Date of Birth',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ClientSignUp2Screen(),
                    ));
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
