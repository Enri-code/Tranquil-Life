import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/services/validators.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_0.dart';
import 'package:tranquil_life/features/auth/presentation/styles.dart';
import 'package:tranquil_life/app/presentation/widgets/mountain_bg.dart';
import 'package:tranquil_life/features/auth/presentation/widgets/forgot_pasword.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';

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
    return CustomBGWidget(
      title: 'Sign In',
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
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
                          listenWhen: (_, __) => !isModalOpen,
                          listener: (context, state) {
                            if (state.status == OperationStatus.error) {
                              _formKey.currentState!.validate();
                            }
                          },
                          child: TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email address',
                              errorStyle: authScreensErrorStyle,
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
                            errorStyle: authScreensErrorStyle,
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
                        color: ColorPalette.yellow,
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
                      context.read<ProfileBloc>().add(const AddUserProfile(
                            Client(
                              id: 1,
                              firstName: 'Chappelle',
                              lastName: 'Eric',
                              email: 'eric@gmail.com',
                              displayName: 'Enrique',
                              phoneNumber: '09069184604',
                              token: '',
                              isVerified: false,
                              hasAnsweredQuestions: false,
                              usesBitmoji: false,
                            ),
                          ));
                      SchedulerBinding.instance.addPostFrameCallback(
                        (_) => context
                            .read<ClientAuthBloc>()
                            .add(const RestoreSignIn()),
                      );
                    },
                    child: const Text('Bypass Login'),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                MyDefaultTextStyle(
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(SignUpScreen.routeName),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: ColorPalette.yellow),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
