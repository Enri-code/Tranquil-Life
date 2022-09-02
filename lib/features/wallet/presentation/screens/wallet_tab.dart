import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card.dart';

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
                if (cardCount < 3)
                  Container(
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
                        onTap: () {},
                        child: const Center(
                          child: Icon(Icons.add, color: Colors.white, size: 26),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          const _Cards(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
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

class _Cards extends StatelessWidget {
  const _Cards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardCount = 3;
    final data = CardData();
    final width = MediaQuery.of(context).size.width - 48;
    final height = width / 1.586;

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
              if (cardCount == 0) {
                return SizedBox(
                  width: width,
                  height: height,
                  child: const _NoCardWidget(),
                );
              }
              if (cardCount == 1) {
                return SizedBox(
                  width: width,
                  height: height,
                  child: CardWidget(index: 0, cardData: data),
                );
              }
              return Swiper(
                itemCount: 3,
                itemWidth: width,
                itemHeight: height,
                layout: SwiperLayout.STACK,
                onTap: (index) {
                  showDialog(
                    context: context,
                    builder: (_) => OptionsDialog([
                      DialogOption(
                        'Set as default',
                        onPressed: () {},
                      ),
                      DialogOption(
                        'Delete card',
                        onPressed: () {},
                      ),
                    ]),
                  );
                },
                itemBuilder: (_, index) =>
                    CardWidget(index: index, cardData: data),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _NoCardWidget extends StatelessWidget {
  const _NoCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
