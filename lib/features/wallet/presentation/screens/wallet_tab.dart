import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/screens/add_card_screen.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_dialog.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/card_widget.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/max_cards_sheet.dart';
import 'package:tranquil_life/features/wallet/presentation/widgets/transaction_sheet.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({Key? key}) : super(key: key);

  @override
  State<WalletTab> createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
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
                const _AddCardButton()
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
          onTap: () {
            if (context.read<WalletBloc>().state.cards!.length < 3 && false) {
              Navigator.of(context).pushNamed(CustomizeCardScreen.routeName);
            } else {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => const MaxCardsSheet(),
              );
            }
          },
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
            BlocBuilder<WalletBloc, WalletState>(builder: (context, state) {
              final cardLength = state.cards?.length ?? 0;
              if (cardLength < 2) {
                final card =
                    cardLength == 1 ? state.cards![0] : CardData.virtual();
                return SizedBox(
                  width: width,
                  height: height,
                  child: CardWidget(index: 0, cardData: card),
                );
              }
              return Swiper(
                itemWidth: width,
                itemHeight: height,
                layout: SwiperLayout.STACK,
                index: state.defaultIndex,
                itemCount: cardLength,
                onTap: (index) {
                  final card = state.cards![index];
                  if (card.type != CardType.virtual ||
                      state.defaultIndex != index) {
                    showDialog(
                      context: context,
                      builder: (_) => CardDialog(card),
                    );
                  }
                },
                itemBuilder: (_, index) => CardWidget(
                  index: index,
                  cardData: state.cards![index],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
