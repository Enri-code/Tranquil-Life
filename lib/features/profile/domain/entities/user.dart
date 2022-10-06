import 'package:json_annotation/json_annotation.dart';

class User {
  const User({
    required this.displayName,
    required this.id,
    this.avatarUrl = '',
  });

  final int id;
  @JsonKey(name: 'username')
  final String displayName;
  @JsonKey()
  final String avatarUrl;
}
