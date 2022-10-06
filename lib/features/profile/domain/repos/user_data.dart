import 'package:tranquil_life/features/profile/domain/entities/client.dart';

abstract class IUserDataStore {
  Client? get user;
  set user(Client? val);

  bool get isUsingAvatar;
  set isUsingAvatar(bool val);

  bool get isSignedIn => user != null;

  Future<void> init();
  Future<void> deleteUser();
}
