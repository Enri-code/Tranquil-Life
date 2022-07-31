import 'package:flutter/material.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_in/sign_in.dart';
import 'package:tranquil_life/features/auth/presentation/screens/client/sign_up/sign_up_0.dart';
import 'package:tranquil_life/features/auth/presentation/screens/user_type_screen.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/consultant_details.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/journal/presentation/screens/journal.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/notifications/presentation/screens/notifications.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/speak_with_consultant.dart';

abstract class AppConfig {
  static const appName = 'Tranquil Life';
  static final routes = <String, WidgetBuilder>{
    UserTypeSreen.routeName: (_) => const UserTypeSreen(),
    ClientSignUpScreen.routeName: (_) => const ClientSignUpScreen(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    ClientDashboardScreen.routeName: (_) => const ClientDashboardScreen(),
    SpeakWithConsultantScreen.routeName: (_) =>
        const SpeakWithConsultantScreen(),
    ConsultantDetailScreen.routeName: (_) => const ConsultantDetailScreen(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    JournalsScreen.routeName: (_) => const JournalsScreen(),
    NoteScreen.routeName: (_) => const NoteScreen(),
  };
}
