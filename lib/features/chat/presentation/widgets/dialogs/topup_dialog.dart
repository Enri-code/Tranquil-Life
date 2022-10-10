import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';

class TopupDialog extends StatelessWidget {
  const TopupDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultCard = context.watch<WalletBloc>().state.defaultCard;
    return OptionsDialog(
      title: Text(
        'Insufficient funds. Top up with:',
        style: TextStyle(
          color: ColorPalette.green[800],
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      options: [
        DialogOption(
          'Default card. ${defaultCard.cardNumber ?? ''}',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const InfoDialog(
                child: Text('Your session has been extended by an hour.'),
              ),
            );
          },
        ),
        DialogOption('Bank transfer', onPressed: () {}),
        DialogOption('Mobile money payment', onPressed: () {}),
        DialogOption('One-time deposit', onPressed: () {}),
      ],
    );
  }
}
