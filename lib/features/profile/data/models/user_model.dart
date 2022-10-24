import 'package:tranquil_life/features/profile/domain/entities/user.dart';

class UserModel extends User {
  UserModel.fromJson(Map<String, dynamic> map)
      : super(displayName: map['display_name']);
}
