import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';

class ForgotPinDialog extends StatelessWidget {
  const ForgotPinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'Forgot Your Pin?',
      bodyText:
          'To unregister this pin from your account, you have to sign out, and then sign back in.',
      yesDialog: DialogOption(
        'Sign Out',
        onPressed: () => getIt<ClientAuthBloc>().add(const SignOut()),
      ),
    );
  }
}
