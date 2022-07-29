import 'package:flutter/material.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_in/sign_in.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_up/sign_up_0.dart';
import 'package:tranquil_life/features/auth/presentation/screens/user_type_screen.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/dashboard.dart';

abstract class AppConfig {
  static const appName = 'Tranquil Life';
  static final routes = <String, WidgetBuilder>{
    UserTypeSreen.routeName: (_) => const UserTypeSreen(),
    ClientSignUpScreen.routeName: (_) => const ClientSignUpScreen(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    ClientDashboardScreen.routeName: (_) => const ClientDashboardScreen(),
  };
}
