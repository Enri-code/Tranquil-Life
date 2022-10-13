import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/domain/entities/client.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';

final signInCase = SignInCase();
final signOutCase = SignOutCase();

class SignInCase {
  void call(Client user) async {
    getIt<ProfileBloc>().add(AddUserProfile(user));
    await Future.delayed(kThemeChangeDuration);
    getIt<IScreenLock>().showLock(LockType.setupPin);
  }
}

class SignOutCase {
  Future call() async {
    getIt<ProfileBloc>().add(const RemoveUserProfile());
    getIt<WalletBloc>().add(const ClearWallet());
    await Future.wait([
      AppData.clearUserData(),
      getIt<IScreenLock>().clear(),
      getIt<IUserDataStore>().deleteUser(),
    ]);
  }
}
