import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/auth/domain/entities/partner.dart';

part 'partner_model.g.dart';

@JsonSerializable(createFactory: true)
class PartnerModel extends Partner {
  const PartnerModel({
    required super.id,
    required super.name,
    required super.logoUrl,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerModelFromJson(json);
}
