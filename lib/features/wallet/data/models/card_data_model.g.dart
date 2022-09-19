// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardDataModel _$CardDataModelFromJson(Map<String, dynamic> json) =>
    CardDataModel(
      cardId: json['card_id'] as int?,
      holderName: json['holder_name'] as String?,
      cardNumber: json['card_number'] as String?,
      expiryDate: json['expiry_date'] as String?,
      CVV: json['c_v_v'] as String?,
      type: $enumDecodeNullable(_$CardTypeEnumMap, json['type']),
    );

const _$CardTypeEnumMap = {
  CardType.visa: 'visa',
  CardType.verve: 'verve',
  CardType.mastercard: 'mastercard',
  CardType.americanExpress: 'americanExpress',
  CardType.virtual: 'virtual',
};
