import 'package:tranquil_life/features/auth/domain/entities/client.dart';

abstract class IUserDataStore {
  Client? get user;
  set user(Client? val);

  bool get isSignedIn;
  set isSignedIn(bool val);

  Future init();
  Future deleteUser();
}
