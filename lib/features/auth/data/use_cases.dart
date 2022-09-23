import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';
import 'package:tranquil_life/features/lock/domain/lock.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';

final signInCase = SignInCase();
final signOutCase = SignOutCase();

class SignInCase {
  Future call(Client user) async {
    getIt<IScreenLock>().setupPin();
    getIt<ProfileBloc>().add(AddUserProfile(user));
  }
}

class SignOutCase {
  Future call() async {
    getIt<ProfileBloc>().add(const RemoveUserProfile());
    await Future.wait([
      AppData.clearUserData(),
      getIt<IScreenLock>().clearPin(),
      getIt<IUserDataStore>().deleteUser(),
    ]);
  }
}
