// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tranquil_life/core/constants/constants.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/calls/data/agora_call.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/onboard.dart';

class AppSetup {
  static init(NavigatorState navigator) async {
    _injectInstances();
    _injectInstancesFromContext(navigator.context);
    chatBoxMaxWidth = MediaQuery.of(navigator.context).size.width * 0.7;
    if (Platform.isAndroid) {
      deviceInfoPlugin.androidInfo.then((value) {
        androidVersion = num.parse(value.version.release ?? '0');
      }).catchError((_) {
        androidVersion = 0;
      });
    }
    await Future.wait([
      Hive.initFlutter().whenComplete(() => AppData.init().then((_) {
            if (!AppData.isOnboardingCompleted) {
              precacheImage(
                const AssetImage('assets/images/onboarding/0.png'),
                navigator.context,
              );
            }
          })),
      Future.delayed(const Duration(milliseconds: 2500)),
    ]);
    _goToScreen(navigator);
  }

  static _goToScreen(NavigatorState navigator) {
    late final String nextRoute;
    if (AppData.isSignedIn) {
      navigator.context.read<ClientAuthBloc>().add(const RestoreSignIn());
      return;
    } else if (AppData.isOnboardingCompleted) {
      nextRoute = SignInScreen.routeName;
    } else {
      nextRoute = OnboardScreen.routeName;
    }
    navigator.popAndPushNamed(nextRoute);
  }

  static _injectInstancesFromContext(BuildContext context) {
    GetIt.instance..registerLazySingleton(() => context.read<ClientAuthBloc>());
  }

  static _injectInstances() {
    GetIt.instance..registerLazySingleton(() => AgoraController());
  }
}
