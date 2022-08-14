import 'package:flutter/material.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sent_reset_email.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_up/sign_up_0.dart';
import 'package:tranquil_life/features/chat/presentation/screens/chat_screen.dart';
import 'package:tranquil_life/features/chat/presentation/screens/image_full_view.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/consultant_details.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/schedule_meeting_screen.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/journal/presentation/screens/journal.dart';
import 'package:tranquil_life/features/journal/presentation/screens/note_screen.dart';
import 'package:tranquil_life/features/notifications/presentation/screens/notifications.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/onboard.dart';
import 'package:tranquil_life/features/profile/presentation/edit_profile.dart';
import 'package:tranquil_life/features/settings/presentation/screens/settings.dart';

abstract class AppConfig {
  static const appName = 'Tranquil Life';

  static final routes = <String, WidgetBuilder>{
    OnboardScreen.routeName: (_) => const OnboardScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    SentPasswordResetEmailScreen.routeName: (_) =>
        const SentPasswordResetEmailScreen(),
    DashboardScreen.routeName: (_) => const DashboardScreen(),
    SpeakWithConsultantScreen.routeName: (_) =>
        const SpeakWithConsultantScreen(),
    ConsultantDetailScreen.routeName: (_) => const ConsultantDetailScreen(),
    ScheduleMeetingScreen.routeName: (_) => const ScheduleMeetingScreen(),
    ChatScreen.routeName: (_) => const ChatScreen(),
    ImageFullView.routeName: (_) => const ImageFullView(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    JournalsScreen.routeName: (_) => const JournalsScreen(),
    NoteScreen.routeName: (_) => const NoteScreen(),
    SettingsScreen.routeName: (_) => const SettingsScreen(),
    EditProfileScreen.routeName: (_) => const EditProfileScreen(),
  };
}
