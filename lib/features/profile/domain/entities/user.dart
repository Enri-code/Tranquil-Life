import 'package:json_annotation/json_annotation.dart';

class User {
  const User({required this.displayName, this.avatarUrl = '', this.authToken});

  @JsonKey(name: 'display_name')
  final String displayName;
  final String avatarUrl;
  final String? authToken;
}
