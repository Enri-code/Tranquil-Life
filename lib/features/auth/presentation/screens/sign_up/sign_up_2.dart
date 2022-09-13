import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tranquil_life/app/presentation/theme/buttons.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';
import 'package:tranquil_life/features/auth/domain/entities/register_data.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/partner/partner_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/styles.dart';
import 'package:tranquil_life/app/presentation/widgets/mountain_bg.dart';

class SignUp2Screen extends StatefulWidget {
  const SignUp2Screen({Key? key}) : super(key: key);

  @override
  State<SignUp2Screen> createState() => _ClientSignUpScreen1State();
}

class _ClientSignUpScreen1State extends State<SignUp2Screen> {
  final _formKey = GlobalKey<FormState>();

  String date = '';
  late RegisterData params;

  @override
  void didChangeDependencies() {
    params = context.read<ClientAuthBloc>().params;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBGWidget(
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: IntlPhoneField(
                    initialValue: params.phone,
                    dropdownTextStyle: const TextStyle(color: Colors.black),
                    pickerDialogStyle: PickerDialogStyle(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    dropdownIconPosition: IconPosition.trailing,
                    flagsButtonPadding: const EdgeInsets.only(left: 12),
                    decoration: const InputDecoration(
                      hintText: 'Phone number',
                      errorStyle: authScreensErrorStyle,
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
                _OrganizationSection(params: params),
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
              }
            },
            builder: (context, state) {
              return Text(
                state.status == OperationStatus.error
                    ? state.error!.message
                    : '',
                style: TextStyle(color: Colors.red[100]),
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
    );
  }
}

class _OrganizationSection extends StatefulWidget {
  const _OrganizationSection({Key? key, required this.params})
      : super(key: key);

  final RegisterData params;

  @override
  State<_OrganizationSection> createState() => _OrganizationSectionState();
}

class _OrganizationSectionState extends State<_OrganizationSection>
    with SingleTickerProviderStateMixin {
  static const _noneValue = 0;

  late final AnimationController _animCnntroller;

  @override
  void initState() {
    final partnersState = context.read<PartnerBloc>().state;
    if (partnersState.partners == null &&
        partnersState.status != OperationStatus.loading) {
      context.read<PartnerBloc>().add(const GetPartnersEvent());
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animCnntroller = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animCnntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<PartnerBloc, PartnerState>(
          builder: (context, state) {
            return DropdownButtonFormField2<int>(
              itemHeight: 56,
              buttonHeight: 38,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(14),
                errorStyle: authScreensErrorStyle,
              ),
              dropdownDecoration: BoxDecoration(
                boxShadow: WidgetsThemeData.dropDownShadow,
                borderRadius: BorderRadius.circular(8),
              ),
              hint: state.partners != null
                  ? const Text('Select organization')
                  : const Text('Getting organizations...'),
              items: state.partners
                      ?.map((e) => DropdownMenuItem(
                            value: e.id,
                            child: _OrganizationItemWidget(partner: e),
                          ))
                      .toList() ??
                  [],
              onChanged: (val) {
                if (val == _noneValue) {
                  _animCnntroller.reverse();
                } else {
                  _animCnntroller.forward();
                }
                widget.params.companyId = val;
              },
              validator: (val) {
                if (val == null) return "Please select an option";
                return null;
              },
            );
          },
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
                decoration: const InputDecoration(hintText: 'Staff ID'),
                validator: (val) {
                  if ((widget.params.companyId ?? _noneValue) == _noneValue) {
                    return null;
                  }
                  if (val!.isEmpty) return 'Your staff ID is required';
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OrganizationItemWidget extends StatelessWidget {
  const _OrganizationItemWidget({Key? key, required this.partner})
      : super(key: key);

  final Partner partner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox.square(
          dimension: 38,
          child: Image.network(
            partner.logoUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.business),
          ),
        ),
        const SizedBox(width: 24),
        Text(
          partner.name,
          style: TextStyle(fontSize: 20, color: Colors.grey[500]!),
        ),
      ],
    );
  }
}
