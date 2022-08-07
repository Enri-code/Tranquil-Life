import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/helpers/validators.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_1.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'client_sign_up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final termsOfServiceGS = TapGestureRecognizer();
  final privacyPolicyGS = TapGestureRecognizer();

  bool isPasswordVisible = true;

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
    var params = context.read<ClientAuthBloc>().params;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign Up'),
      body: SafeArea(
        child: UnfocusWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
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
                              child: BlocListener<ClientAuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state.status == OperationStatus.error) {
                                    _formKey.currentState!.validate();
                                  }
                                },
                                child: TextFormField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: 'Email',
                                  ),
                                  validator: (val) {
                                    var state =
                                        context.read<ClientAuthBloc>().state;
                                    if (val!.isEmpty) {
                                      return 'Please input your email';
                                    }
                                    if (!Validator.isEmail(val)) {
                                      return 'Please input a valid email address';
                                    }
                                    if (state.status == OperationStatus.error &&
                                        state.error?.cause is EmailError) {
                                      return state.error!.message;
                                    }
                                    params.email = val;
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: TextFormField(
                                autocorrect: false,
                                obscureText: isPasswordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        isPasswordVisible = !isPasswordVisible),
                                    icon: isPasswordVisible
                                        ? const Icon(Icons.visibility_off)
                                        : Icon(
                                            Icons.visibility,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                  ),
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please input a strong password';
                                  }
                                  if (val.length < 6) {
                                    return 'Your password should be at least 6 charactors long';
                                  }
                                  params.password = val;
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: TextFormField(
                                autocorrect: false,
                                obscureText: isPasswordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  hintText: 'Confirm Password',
                                ),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please re-type your password';
                                  }
                                  if (params.password != val) {
                                    return 'Your passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ClientAuthBloc>()
                              .add(const RemoveError());
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            if (_formKey.currentState!.validate()) {
                              //TODO: check email first
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const SignUp1Screen(),
                              ));
                            }
                          });
                        },
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
