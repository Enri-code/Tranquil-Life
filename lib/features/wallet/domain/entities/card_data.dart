// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

enum CardType { visa, verve, mastercard, virtual }

class CardData extends Equatable {
  final int? cardId;
  final String? holderName;
  final String? cardNumber;
  final String? expiryDate;
  final String? CVV;
  final CardType? type;

  const CardData({
    required this.cardId,
    required this.holderName,
    required this.cardNumber,
    required this.expiryDate,
    required this.CVV,
    required this.type,
  });

  factory CardData.virtual() => const CardData(
        cardId: 0,
        holderName: null,
        cardNumber: null,
        expiryDate: null,
        CVV: null,
        type: CardType.virtual,
      );

  factory CardData.empty() => const CardData(
        cardId: null,
        holderName: '',
        cardNumber: '',
        expiryDate: '',
        CVV: null,
        type: null,
      );

  CardData copyWith({
    String? holderName,
    String? cardNumber,
    String? expiryDate,
    String? CVV,
    CardType? type,
  }) {
    return CardData(
      cardId: cardId,
      holderName: holderName ?? this.holderName,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      CVV: CVV ?? this.CVV,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [holderName, cardNumber, expiryDate, CVV, type];
}
