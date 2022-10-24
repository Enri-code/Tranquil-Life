import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/theme/properties.dart';
import 'package:tranquil_life/core/utils/services/formatters.dart';
import 'package:tranquil_life/features/wallet/presentation/screens/add_card_screen.dart';
import 'package:tranquil_life/samples/cards.dart';

class MaxCardsSheet extends StatefulWidget {
  const MaxCardsSheet({super.key});

  @override
  State<MaxCardsSheet> createState() => _MaxCardsSheetState();
}

class _MaxCardsSheetState extends State<MaxCardsSheet> {
  int groupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
      decoration: bottomSheetDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Max: 3 Cards',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          RichText(
            text: TextSpan(
              text: '😔 ',
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: 'Oops! Your card slots are full.\n\n'
                      'What card would you like to ',
                  style: Theme.of(context).textTheme.bodyMedium!,
                  children: [
                    TextSpan(
                      text: 'replace',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const TextSpan(text: '?'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          RadioTheme(
            data: RadioThemeData(
              visualDensity: VisualDensity.comfortable,
              fillColor: MaterialStatePropertyAll(
                Theme.of(context).primaryColor,
              ),
            ),
            child: Column(
              children: List.generate(
                cards.length,
                (index) {
                  // final card = context.read<WalletBloc>().state.cards![index];
                  final card = cards[index];
                  return _CardNumberTile(
                    index: index,
                    groupIndex: groupIndex,
                    number: card.cardNumber!,
                    onSelected: groupIndex > 0
                        ? null
                        : (_) async {
                            setState(() => groupIndex = index);
                            await Future.delayed(kTabScrollDuration);
                            Navigator.of(context).popAndPushNamed(
                              CustomizeCardScreen.routeName,
                              arguments: card,
                            );
                          },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}

class _CardNumberTile extends StatelessWidget {
  const _CardNumberTile({
    required this.number,
    required this.index,
    required this.groupIndex,
    this.onSelected,
  });

  final int index, groupIndex;
  final String number;
  final Function(int? value)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: GestureDetector(
        onTap: () => onSelected?.call(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              Text(
                CardNumberFormatter.formatNumber(number, obscureChar: '*'),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              Radio<int>(
                value: index,
                groupValue: groupIndex,
                onChanged: onSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
