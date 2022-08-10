import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/partner/partner_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_2.dart';
import 'package:tranquil_life/features/auth/presentation/styles.dart';
import 'package:tranquil_life/features/auth/presentation/widgets/auth_bg.dart';

class SignUp1Screen extends StatefulWidget {
  const SignUp1Screen({Key? key}) : super(key: key);

  @override
  State<SignUp1Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<SignUp1Screen> {
  final _formKey = GlobalKey<FormState>();
  final _dateTextController = TextEditingController();

  String date = '';
  late RegisterData params;

  @override
  void initState() {
    context.read<PartnerBloc>().add(const GetPartnersEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    params = context.read<ClientAuthBloc>().params;
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
    return AuthBGWidget(
      title: 'Sign Up',
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
                    initialValue: params.firstName,
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
                    decoration: InputDecoration(
                      hintText: 'Display name',
                      errorStyle: authScreensErrorStyle,
                      suffixIcon: IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => const FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Dialog(
                              child: _UsernameInfoDialog(),
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.info_outline),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Your display name will be shown to consultants';
                      }
                      params.displayName = val;
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: GestureDetector(
                    onTap: () async {
                      var val = await showPickerForDate(context);
                      _dateTextController.text =
                          val?.formatted ?? _dateTextController.text;
                      params.birthDate = val?.folded ?? params.birthDate;
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _dateTextController,
                        decoration: const InputDecoration(
                          hintText: 'Date of Birth',
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Your Date of Birth will be kept private.';
                          }
                          return null;
                        },
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
              if (_formKey.currentState!.validate() || true) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const SignUp2Screen(),
                ));
              }
            },
            child: const Text('Next'),
          ),
        ],
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
