import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable(createToJson: true)
class Client {
  const Client({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.displayName,
    required this.phoneNumber,
    this.birthDate,
    /*this.gender,
    this.location, */
    required this.isVerified,
  });

  @JsonKey(name: 'f_name')
  final String firstName;
  @JsonKey(name: 'l_name')
  final String lastName;
  final String email;
  @JsonKey()
  final String? avatarUrl;
  final String displayName;
  @JsonKey(name: 'phone')
  final String phoneNumber;
  final String? birthDate;

/*  final String? gender;
  final String? location; */

  @JsonKey(name: 'email_verified_at', fromJson: isVerifiedFromJson)
  final bool isVerified;

  Map<String, dynamic> toJson() => _$ClientToJson(this);
}

isVerifiedFromJson(dynamic jsonValue) => jsonValue != null;
