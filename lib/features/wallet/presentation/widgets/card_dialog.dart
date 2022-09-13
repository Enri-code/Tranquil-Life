import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

class CardDialog extends StatelessWidget {
  final CardData card;
  const CardDialog(this.card, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OptionsDialog([
      DialogOption(
        'Set as default',
        onPressed: () {},
      ),
      DialogOption(
        'Delete card',
        onPressed: () {},
      ),
    ]);
  }
}
