import 'package:tranquil_life/features/profile/domain/entities/client.dart';

abstract class IUserDataStore {
  Client? get user;
  set user(Client? val);

  String get token;
  set token(String val);

  bool get isUsingAvatar;
  set isUsingAvatar(bool val);

  Future<void> init();
  Future<void> deleteUser();
}
