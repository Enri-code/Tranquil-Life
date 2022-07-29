import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';

class ClientSignUp2Screen extends StatefulWidget {
  const ClientSignUp2Screen({Key? key}) : super(key: key);

  @override
  State<ClientSignUp2Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<ClientSignUp2Screen> {
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
                        child: GestureDetector(
                          onTap: () {},
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Location',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            hintText: 'Organization',
                          ),
                          validator: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
