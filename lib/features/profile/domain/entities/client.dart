import 'package:json_annotation/json_annotation.dart';
import 'package:tranquil_life/features/profile/domain/entities/user.dart';

part 'client.g.dart';

@JsonSerializable(createToJson: true)
class Client extends User {
  const Client({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required super.displayName,
    required this.usesBitmoji,
    this.isVerified = false,
    this.hasAnsweredQuestions = false,
    super.avatarUrl,
    this.birthDate,
    this.gender,
    this.staffId,
    this.companyName,
  });

  final int id;
  @JsonKey(name: 'f_name')
  final String firstName;
  @JsonKey(name: 'l_name')
  final String lastName;
  final String email;

  @JsonKey(name: 'phone')
  final String phoneNumber;
  final String? birthDate, gender, staffId, companyName;

  final bool hasAnsweredQuestions, usesBitmoji;

  final bool isVerified;

  String get name => '$firstName $lastName';

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
