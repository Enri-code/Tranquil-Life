import 'package:tranquil_life/core/utils/helpers/store.dart';
import 'package:tranquil_life/features/auth/data/models/client_model.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/domain/repos/user_data.dart';

abstract class _Keys {
  static const user = 'user';
  static const isSignedIn = 'isSignedIn';
}

class UserDataStore extends IUserDataStore {
  static final _store = HiveStore('user_data');

  @override
  Client? get user {
    final val = _store.get(_Keys.user);
    if (val == null) return null;
    return ClientModel.fromJson(val);
  }

  @override
  set user(Client? val) => _store.set(_Keys.user, val?.toJson());

  @override
  bool get isSignedIn => _store.get(_Keys.isSignedIn) ?? false;

  @override
  set isSignedIn(bool val) => _store.set(_Keys.isSignedIn, val);

  @override
  Future init() => _store.init();

  @override
  Future deleteUser() => _store.deleteAll([_Keys.user, _Keys.isSignedIn]);
}
