import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/onboard.dart';

class AppSetup {
  static init(BuildContext context) async {
    var dataInit = Hive.initFlutter().whenComplete(() => AppData.init());
    dataInit.whenComplete(() {});
    var navigator = Navigator.of(context);
    await Future.wait([
      dataInit,
      Future.delayed(const Duration(milliseconds: 2500)),
    ]);
    goToScreen(navigator);
  }

  static goToScreen(NavigatorState navigator) {
    String nextRoute;
    if (AppData.isSignedIn) {
      nextRoute = DashboardScreen.routeName;
    } else if (AppData.isOnboardingCompleted) {
      nextRoute = SignInScreen.routeName;
    } else {
      nextRoute = OnboardScreen.routeName;
    }
    navigator.popAndPushNamed(nextRoute);
  }
}
