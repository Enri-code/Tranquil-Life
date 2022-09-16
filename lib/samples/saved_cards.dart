import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

final savedCards = [
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
