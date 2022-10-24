import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/services/formatters.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';

class CardWidget extends StatelessWidget {
  final int? index;
  final CardData cardData;
  const CardWidget({Key? key, required this.cardData, this.index})
      : super(key: key);

  Widget _cardTypeWidget(CardType type) {
    switch (type) {
      case CardType.visa:
        return Image.asset('assets/images/wallet/networks/visa.png');
      case CardType.verve:
        return Image.asset('assets/images/wallet/networks/verve.png');
      case CardType.mastercard:
        return Image.asset('assets/images/wallet/networks/mastercard.png');
      case CardType.americanExpress:
        return Image.asset(
          'assets/images/wallet/networks/american_express.png',
        );
      case CardType.virtual:
        return const Icon(TranquilIcons.logo, color: Colors.white, size: 33);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, right: 6),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BlocBuilder<WalletBloc, WalletState>(
                  builder: (context, state) {
                    final cardBgIndex = index ?? state.cards?.length ?? 1;
                    return Image.asset(
                      'assets/images/wallet/cards/card_$cardBgIndex.jpg',
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              MyDefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'assets/images/wallet/card_chip.png',
                        ),
                      ),
                      SizedBox(
                        height: 38,
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(CardNumberFormatter.formatNumber(
                            cardData.cardNumber ?? '0000000000000000',
                          )),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Valid Till:  ',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              cardData.expiryDate ?? 'Forever',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cardData.holderName ??
                                  context
                                      .watch<ProfileBloc>()
                                      .state
                                      .user!
                                      .displayName,
                            ),
                            if (cardData.type != null)
                              _cardTypeWidget(cardData.type!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            if (state.defaultIndex != index) return const SizedBox();
            return Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
            );
          },
        )
      ],
    );
  }
}
