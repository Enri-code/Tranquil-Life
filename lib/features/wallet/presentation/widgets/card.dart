import 'package:flutter/material.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final CardData cardData;
  const CardWidget({Key? key, required this.cardData, this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/wallet/cards/card_$index.jpg',
            fit: BoxFit.scaleDown,
          ),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
