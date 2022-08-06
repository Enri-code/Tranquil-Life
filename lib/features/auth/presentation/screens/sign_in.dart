import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/services/custom_loader.dart';
import 'package:tranquil_life/core/utils/helpers/validators.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_0.dart';
import 'package:tranquil_life/features/auth/presentation/widgets/forgot_pasword.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'sign_in';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = true, isModalOpen = false;
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign In'),
      body: SafeArea(
        child: UnfocusWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 20),
                  child: Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                const Text(
                  'Sign In with your email and password',
                  style: TextStyle(fontSize: 18, height: 1.5),
                  textAlign: TextAlign.center,
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
                            if (isModalOpen) return;
                            if (state.status == OperationStatus.loading) {
                              CustomLoader.display();
                            } else {
                              CustomLoader.remove();
                              if (state.status == OperationStatus.error) {
                                _formKey.currentState!.validate();
                              } else if (state.status ==
                                  OperationStatus.success) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  DashboardScreen.routeName,
                                  (_) => false,
                                );
                              }
                            }
                          },
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Your email',
                            ),
                            validator: (val) {
                              var state = context.read<ClientAuthBloc>().state;
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
                              email = val;
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
                              onPressed: () => setState(
                                  () => isPasswordVisible = !isPasswordVisible),
                              icon: isPasswordVisible
                                  ? const Icon(Icons.visibility_off)
                                  : Icon(
                                      Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please input your password';
                            }
                            if (val.length < 6) {
                              return 'Your password should be at least 6 charactors long';
                            }
                            password = val;
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      isModalOpen = true;
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const ForgotPasswordBottomSheet(),
                      ).then((value) => isModalOpen = false);
                    },
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    context.read<ClientAuthBloc>().add(const RemoveError());
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      if (_formKey.currentState!.validate()) {
                        context.read<ClientAuthBloc>().add(
                              SignIn(email, password),
                            );
                      }
                    });
                  },
                  child: const Text('Sign In'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        DashboardScreen.routeName,
                        (_) => false,
                      );
                    },
                    child: const Text('Bypass Login'),
                  ),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(SignUpScreen.routeName),
                        child: Text(
                          'Sign up',
                          style: TextStyle(color: ColorPalette.primary[800]!),
                        ),
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
    );
  }
}
