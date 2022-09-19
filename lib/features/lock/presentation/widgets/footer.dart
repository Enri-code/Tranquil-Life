import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';

class Footer extends StatelessWidget {
  const Footer(
    this.isPinSetup, {
    Key? key,
    required this.controller,
  }) : super(key: key);

  final bool isPinSetup;
  final InputController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Theme(
        data: Theme.of(context).copyWith(
            textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Colors.white),
        )),
        child: Builder(builder: (context) {
          if (isPinSetup) {
            return TextButton(
              onPressed: () => controller.unsetConfirmed(),
              child: const Text('RESET'),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => const _ForgotPinDialog(),
                ),
                child: const Text('FORGOT PIN?'),
              ),
              TextButton(
                onPressed: () => getIt<ClientAuthBloc>().add(const SignOut()),
                child: const Text('SIGN OUT'),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ForgotPinDialog extends StatelessWidget {
  const _ForgotPinDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      title: 'Forgot Your Pin?',
      bodyText:
          'To unregister this pin from your account, you have to sign out, and then sign back in to ${AppConfig.appName}.',
      yesDialog: DialogOption(
        'Sign Out',
        onPressed: () => getIt<ClientAuthBloc>().add(const SignOut()),
      ),
    );
  }
}
