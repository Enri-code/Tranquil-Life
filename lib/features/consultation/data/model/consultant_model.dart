import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

part 'consultant_model.g.dart';

@JsonSerializable(createFactory: true)
class ConsultantModel extends Consultant {
  const ConsultantModel({
    required super.id,
    required super.name,
    required super.specialties,
    required super.description,
    super.avatarUrl,
  });

  factory ConsultantModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultantModelFromJson(json);
}
