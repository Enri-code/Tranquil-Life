import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';

class CardDialog extends StatelessWidget {
  final CardData card;
  const CardDialog(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletBloc = context.read<WalletBloc>();
    return OptionsDialog(options: [
      if (walletBloc.state.defaultIndex !=
          walletBloc.state.cards!.indexOf(card))
        DialogOption(
          'Set as default',
          onPressed: () {
            walletBloc
                .add(SetDefaultCard(walletBloc.state.cards!.indexOf(card)));
          },
        ),
      if (card.type != CardType.virtual)
        DialogOption(
          'Delete card',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => ConfirmDialog(
                title: 'Delete This Card?',
                bodyText:
                    'Are you sure you want to delete this card\'s information from ${AppConfig.appName}?',
                yesDialog: DialogOption(
                  'Delete Card',
                  onPressed: () => walletBloc.add(RemoveCard(card)),
                ),
              ),
            );
          },
        ),
    ]);
  }
}
