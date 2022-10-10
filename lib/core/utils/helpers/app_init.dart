import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/profile/data/repos/user_data.dart';
import 'package:tranquil_life/features/profile/domain/repos/user_data.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/chat/data/agora_call.dart';
import 'package:tranquil_life/features/chat/domain/repos/video_call_repo.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/onboard.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/screen_lock/data/lock.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';

class AppSetup {
  static bool _isInit = false;
  static init(NavigatorState navigator) async {
    if (_isInit) return;
    _injectInstances(navigator.context);
    chatBoxMaxWidth = MediaQuery.of(navigator.context).size.width * 0.7;
    if (Platform.isAndroid) {
      deviceInfoPlugin.androidInfo.then((value) {
        androidVersion = num.parse(value.version.release ?? '0');
      }).catchError((_) {
        androidVersion = 0;
      });
    }
    final hiveFuture = Hive.initFlutter().whenComplete(() async {
      _injectStoreInstances();
      return AppData.init();
    });
    _isInit = true;
    await Future.wait([
      hiveFuture.whenComplete(() {
        if (!AppData.isOnboardingCompleted) {
          precacheImage(
            const AssetImage('assets/images/onboarding/0.png'),
            navigator.context,
          );
        }
      }),
      Future.delayed(const Duration(milliseconds: 2500)),
    ]);
    _goToScreen(navigator);
  }

  static _goToScreen(NavigatorState navigator) async {
    late final String nextRoute;
    if (getIt<IUserDataStore>().isSignedIn) {
      final didAuthenticate = await getIt<IScreenLock>().showLock();
      if (didAuthenticate) getIt<ClientAuthBloc>().add(const RestoreSignIn());
      return;
    } else if (AppData.isOnboardingCompleted) {
      nextRoute = SignInScreen.routeName;
    } else {
      nextRoute = OnboardScreen.routeName;
    }
    navigator.popAndPushNamed(nextRoute);
  }

  static _injectStoreInstances() {
    GetIt.instance.registerSingleton<IUserDataStore>(UserDataStore());
  }

  static _injectInstances(BuildContext context) {
    GetIt.instance
      ..registerSingleton(context.read<ClientAuthBloc>())
      ..registerSingleton(context.read<ProfileBloc>())
      ..registerSingleton(context.read<WalletBloc>())
      ..registerSingleton<IScreenLock>(
        ScreenLock()..init(Navigator.of(context)),
      )
      ..registerLazySingleton<CallController>(() => AgoraController());
  }
}
