import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';

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
        onPressed: () {
          final clientBloc = getIt<ClientAuthBloc>()..add(const SignOut());
          if (!clientBloc.state.isSignedIn) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              SignInScreen.routeName,
              (_) => false,
            );
          }
        },
      ),
    );
  }
}
