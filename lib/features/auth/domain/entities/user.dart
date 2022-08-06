import 'package:json_annotation/json_annotation.dart';

abstract class User {
  @JsonKey(name: 'f_name')
  final String firstName;
  @JsonKey(name: 'l_name')
  final String lastName;
  final String email;
  final String avatarUrl;

  const User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });
}
