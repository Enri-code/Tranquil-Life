import 'package:tranquil_life/app/data/repos/store.dart';
import 'package:tranquil_life/features/auth/data/models/client_model.dart';
import 'package:tranquil_life/features/auth/domain/entities/client.dart';
import 'package:tranquil_life/features/auth/domain/repos/user_data.dart';

abstract class _Keys {
  static const user = 'user';
  static const usingAvatar = 'usingAvatar';
}

class UserDataStore extends IUserDataStore {
  UserDataStore() {
    init();
  }

  static final _store = HiveStore('user_data');

  @override
  Client? get user {
    final val = _store.get(_Keys.user);
    if (val == null) return null;
    return ClientModel.fromJson(Map.from(val));
  }

  @override
  set user(Client? val) => _store.set(_Keys.user, val?.toJson());

  @override
  bool get isUsingAvatar => _store.get(_Keys.usingAvatar) ?? false;

  @override
  set isUsingAvatar(bool val) => _store.set(_Keys.usingAvatar, val);

  @override
  Future init() => _store.init();

  @override
  Future deleteUser() => _store.deleteAll();
}
