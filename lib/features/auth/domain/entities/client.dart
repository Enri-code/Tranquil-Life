import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/auth/domain/entities/user.dart';

part 'client.g.dart';

@JsonSerializable(createToJson: true)
class Client extends User {
  Client({
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.avatarUrl,
  });

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
