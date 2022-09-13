import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/screens/add_card_screen.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_dialog.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_widget.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/transaction_sheet.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  int cardCount = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  TranquilIcons.wallet_checkmark,
                  color: ColorPalette.green[800],
                  size: 32,
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r'$40,000',
                      style: TextStyle(
                        fontSize: 24,
                        color: ColorPalette.green[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Available Balance',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                if (cardCount < 3) const _AddCardButton()
              ],
            ),
          ),
          const _Cards(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const TransactionsSheet(),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(width: 6),
                      Text('View Transactions'),
                      SizedBox(width: 12),
                      Icon(Icons.keyboard_arrow_down, size: 28),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Top Up Your Account'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCardButton extends StatelessWidget {
  const _AddCardButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorPalette.green[800],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          radius: 16,
          onTap: () => Navigator.of(context).pushNamed(AddCardScreen.routeName),
          child: const Center(
            child: Icon(Icons.add, color: Colors.white, size: 26),
          ),
        ),
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  const _Cards({Key? key}) : super(key: key);

  static final savedCards = [
    CardData.virtual(),
    const CardData(
      cardId: 1,
      holderName: null,
      cardNumber: '5567458525329686',
      expiryDate: '07/15',
      CVV: '563',
      type: CardType.mastercard,
    ),
    const CardData(
      cardId: 2,
      holderName: null,
      cardNumber: '5567458525329686',
      expiryDate: '07/18',
      CVV: '4954',
      type: CardType.visa,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 42;
    final height = width / cardAspectRatio;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.57,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/wallet/confetti.png'),
                  const SizedBox(width: 8),
                  const Flexible(
                    child: Text(
                      'You have 15% discount on\nyour first 3 consultations.',
                      style: TextStyle(height: 1, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Builder(builder: (context) {
              if (savedCards.isEmpty) {
                return SizedBox(
                  width: width,
                  height: height,
                  child: CardWidget(
                    index: 0,
                    cardData: CardData.virtual(),
                  ),
                );
              }
              return Swiper(
                index: 0, //default/initial index
                itemWidth: width,
                itemHeight: height,
                layout: SwiperLayout.STACK,
                itemCount: savedCards.length,
                onTap: (index) {
                  showDialog(
                    context: context,
                    builder: (_) => CardDialog(savedCards[index]),
                  );
                },
                itemBuilder: (_, index) {
                  return CardWidget(index: index, cardData: savedCards[index]);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
