import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/helpers/validators.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sent_reset_email.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  String email = '';
  String error = '';

  void _continue() {
    if (Validator.isEmail(email)) {
      setState(() => error = '');
      context.read<ClientAuthBloc>().add(ResetPassword(email));
    } else {
      setState(() => error = 'Please input a valid email address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(38),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            const Text(
              'We will send you a link to\nreset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.3),
            ),
            const SizedBox(height: 30),
            TextField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Your account's email",
              ),
              onChanged: (val) {
                setState(() => email = val);
                if (val.isEmpty) {
                  setState(() => error = 'Please input your email address');
                } else {
                  setState(() => error = '');
                }
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 30,
              child: Text(
                error,
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              child: Center(
                child: BlocConsumer<ClientAuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status == OperationStatus.success) {
                      Navigator.of(context).popAndPushNamed(
                        SentPasswordResetEmailScreen.routeName,
                        arguments: email,
                      );
                    } else if (state.status == OperationStatus.error) {
                      setState(() => error = state.error!.message);
                    }
                  },
                  builder: (context, state) {
                    if (state.status == OperationStatus.loading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: email.isEmpty ? null : _continue,
                      child: const Text('Reset Password'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
