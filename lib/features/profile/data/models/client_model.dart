import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';

part 'client_model.g.dart';

@JsonSerializable(createFactory: true)
class ClientModel extends Client {
  const ClientModel({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.token,
    required super.id,
    required super.displayName,
    required super.phoneNumber,
    required super.isVerified,
    required super.hasAnsweredQuestions,
    required super.usesBitmoji,
    super.avatarUrl,
    super.birthDate,
    super.gender,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}
