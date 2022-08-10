import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';

part 'client_model.g.dart';

@JsonSerializable(createFactory: true)
class ClientModel extends Client {
  const ClientModel({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatarUrl,
    required super.displayName,
    required super.phoneNumber,
    required super.isVerified,
    super.birthDate,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}
