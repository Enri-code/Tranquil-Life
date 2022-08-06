import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';

part 'client_model.g.dart';

@JsonSerializable(createFactory: true)
class ClientModel extends Client {
  ClientModel({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatarUrl,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}
