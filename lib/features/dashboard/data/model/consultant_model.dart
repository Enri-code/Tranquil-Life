import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/dashboard/domain/entities/consultant.dart';

part 'consultant_model.g.dart';

@JsonSerializable(createFactory: true)
class ConsultantModel extends Consultant {
  const ConsultantModel({required super.uid, required super.name});

  factory ConsultantModel.fromJson(Map<String, dynamic> json) =>
      _$ConsultantModelFromJson(json);
}
