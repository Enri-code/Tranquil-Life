// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/wallet/domain/entities/card_data.dart';

part 'card_data_model.g.dart';

@JsonSerializable(createFactory: true)
class CardDataModel extends CardData {
  const CardDataModel({
    required super.cardId,
    required super.holderName,
    required super.cardNumber,
    required super.expiryDate,
    required super.CVV,
    required super.type,
  });

  factory CardDataModel.fromJson(Map<String, dynamic> json) =>
      _$CardDataModelFromJson(json);
}
