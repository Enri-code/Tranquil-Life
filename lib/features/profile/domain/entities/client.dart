import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/profile/domain/entities/user.dart';

part 'client.g.dart';

@JsonSerializable(createToJson: true)
class Client extends User {
  const Client({
    required super.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required super.displayName,
    required this.usesBitmoji,
    required this.token,
    this.isVerified = false,
    this.hasAnsweredQuestions = false,
    super.avatarUrl,
    this.birthDate,
    this.gender,
  });

  @JsonKey(name: 'f_name')
  final String firstName;
  @JsonKey(name: 'l_name')
  final String lastName;
  final String email;

  @JsonKey(name: 'phone')
  final String phoneNumber;
  final String? birthDate;
  final String? gender;

  final String token;
  final bool hasAnsweredQuestions, usesBitmoji;

  @JsonKey(name: 'email_verified_at', fromJson: isVerifiedFromJson)
  final bool isVerified;

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

isVerifiedFromJson(dynamic jsonValue) => jsonValue != null;
