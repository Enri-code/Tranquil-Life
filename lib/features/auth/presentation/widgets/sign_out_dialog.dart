import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'Sign Out?',
      bodyText: 'You are about to sign out of your account on this device.',
      yesDialog: DialogOption(
        'Sign Out',
        onPressed: () {
          final clientBloc = getIt<AuthBloc>()..add(const SignOut());
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
