// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'stringify': instance.stringify,
      'hash_code': instance.hashCode,
      'card_id': instance.cardId,
      'holder_name': instance.holderName,
      'card_number': instance.cardNumber,
      'expiry_date': instance.expiryDate,
      'c_v_v': instance.CVV,
      'type': _$CardTypeEnumMap[instance.type],
    };

const _$CardTypeEnumMap = {
  CardType.visa: 'visa',
  CardType.verve: 'verve',
  CardType.mastercard: 'mastercard',
  CardType.americanExpress: 'americanExpress',
  CardType.virtual: 'virtual',
};
