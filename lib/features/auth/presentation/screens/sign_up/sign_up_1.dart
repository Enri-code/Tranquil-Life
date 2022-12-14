import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_2.dart';
import 'package:tranquil_life/features/auth/presentation/styles.dart';
import 'package:tranquil_life/app/presentation/widgets/mountain_bg.dart';

class SignUp1Screen extends StatefulWidget {
  const SignUp1Screen({Key? key}) : super(key: key);

  @override
  State<SignUp1Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<SignUp1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _dateTextController = TextEditingController();

  late RegisterData params;

  @override
  void didChangeDependencies() {
    params = context.read<AuthBloc>().params;
    _dateTextController.text = params.birthDate;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBGWidget(
      title: 'Sign Up',
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 32, bottom: 20),
              child: Text('Register Account', style: TextStyle(fontSize: 36)),
            ),
            const Text('Complete your profile', style: TextStyle(fontSize: 18)),
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
                      initialValue: params.firstName,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                        errorStyle: authScreensErrorStyle,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'What is your first name? This will be kept private';
                        }
                        params.firstName = val;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      autocorrect: false,
                      initialValue: params.lastName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                        errorStyle: authScreensErrorStyle,
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'What is your last name? This will be kept private';
                        }
                        params.lastName = val;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: TextFormField(
                      autocorrect: false,
                      initialValue: params.displayName,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Display name',
                        errorStyle: authScreensErrorStyle,
                        suffixIcon: IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => const FractionallySizedBox(
                              widthFactor: 0.9,
                              child: Dialog(child: _UsernameInfoDialog()),
                            ),
                          ),
                          icon: const Icon(Icons.info_outline),
                        ),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Your display name will be displayed to consultants';
                        }
                        params.displayName = val;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Stack(
                      children: [
                        IgnorePointer(
                          child: TextFormField(
                            controller: _dateTextController,
                            decoration: const InputDecoration(
                              hintText: 'Date of Birth',
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final date = await showCustomDatePicker(
                                context,
                                minDateFromNow: DateTime(-100, 0, 0),
                                maxDateFromNow: DateTime(-16, 0, 0),
                              );
                              if (date != null) {
                                _dateTextController.text = date.formatted;
                                params.birthDate = date.folded;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const SignUp2Screen(),
                  ));
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameInfoDialog extends StatelessWidget {
  const _UsernameInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Your "Display name" is what would be displayed during consultations. Your first name and last name will be kept private.',
        style: TextStyle(fontSize: 17, height: 1.5),
        textAlign: TextAlign.center,
      ),
    );
  }
}
