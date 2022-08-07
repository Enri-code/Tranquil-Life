import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/services/custom_loader.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';

class SignUp2Screen extends StatefulWidget {
  const SignUp2Screen({Key? key}) : super(key: key);

  @override
  State<SignUp2Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<SignUp2Screen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _companyTextController = TextEditingController();
  late final AnimationController _animCnntroller;

  String date = '';
  late RegisterData params;

  @override
  void didChangeDependencies() {
    _animCnntroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    params = context.read<ClientAuthBloc>().params;
    _companyTextController.text = params.companyId;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animCnntroller.dispose();
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
            child: SingleChildScrollView(
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
                          child: IntlPhoneField(
                            initialValue: params.phone,
                            pickerDialogStyle: PickerDialogStyle(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 16),
                            ),
                            autovalidateMode: AutovalidateMode.disabled,
                            dropdownIconPosition: IconPosition.trailing,
                            flagsButtonPadding: const EdgeInsets.only(left: 12),
                            decoration: const InputDecoration(
                              hintText: 'Phone number',
                            ),
                            onChanged: (val) {
                              var number = val.number.startsWith('0')
                                  ? val.number.substring(1)
                                  : val.number;
                              params.phone = '${val.countryCode}$number';
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final String val = '';
                            if (val.isEmpty) {
                              _animCnntroller.reverse();
                            } else {
                              _animCnntroller.forward();
                            }
                            setState(() {
                              params.companyId =
                                  _companyTextController.text = val;
                            });
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              autocorrect: false,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                hintText: 'Organization',
                              ),
                            ),
                          ),
                        ),
                        SizeTransition(
                          sizeFactor: _animCnntroller,
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.name,
                                textCapitalization: TextCapitalization.words,
                                decoration: const InputDecoration(
                                  hintText: 'Staff ID',
                                ),
                                validator: (val) {
                                  if (params.companyId.isEmpty) return null;
                                  if (val!.isEmpty) {
                                    return 'Your staff ID is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<ClientAuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.status == OperationStatus.loading) {
                        CustomLoader.display();
                      } else {
                        CustomLoader.remove();
                        if (state.status == OperationStatus.success) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            DashboardScreen.routeName,
                            (_) => false,
                          );
                        }
                      }
                    },
                    builder: (context, state) {
                      return Text(
                        state.status == OperationStatus.error
                            ? state.error!.message
                            : '',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).errorColor,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ClientAuthBloc>().add(const SignUp());
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
