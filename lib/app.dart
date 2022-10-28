import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/theme_data.dart';
import 'package:tranquil_life/app/presentation/widgets/input_listener.dart';
import 'package:tranquil_life/core/utils/helpers/app_init.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/auth/data/repos/client_auth.dart';
import 'package:tranquil_life/features/auth/data/repos/partners.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/partner/partner_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/journal/data/repos/journal_repo.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/splash.dart';
import 'package:tranquil_life/features/profile/data/repos/profile_repo.dart';
import 'package:tranquil_life/features/profile/domain/repos/profile_repo.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/data/repos/questionnaire_repo.dart';
import 'package:tranquil_life/features/questionnaire/presentation/bloc/questionnaire_bloc.dart';
import 'package:tranquil_life/features/screen_lock/domain/lock.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/edit_card/edit_card_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';
import 'package:tranquil_life/samples/notes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  _onSignIn(BuildContext context) async {
    context.read<ProfileBloc>().add(const RestoreUserProfile());
    context.read<JournalBloc>().add(GetNotes(notes));
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(true);
    precacheImage(const AssetImage('assets/images/mountains_bg.png'), context);
    return RepositoryProvider<ProfileRepo>(
      create: (context) => const ProfileRepoImpl(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepo: const AuthRepoImpl(),
              profileRepo: context.read<ProfileRepo>(),
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => ProfileBloc(context.read<ProfileRepo>()),
            lazy: false,
          ),
          BlocProvider(create: (_) => PartnerBloc(const PartnersRepoImpl())),
          BlocProvider(create: (_) => ConsultantBloc()),
          BlocProvider(create: (_) => JournalBloc(const JournalRepoImpl())),
          BlocProvider(create: (_) => NoteBloc()),
          BlocProvider(create: (_) => ChatBloc()),
          BlocProvider(create: (_) => EditCardBloc()),
          BlocProvider(create: (_) => WalletBloc()),
          BlocProvider(
            create: (_) => QuestionnaireBloc(const QuestionnaireRepoImpl()),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (prev, curr) => prev.isSignedIn != curr.isSignedIn,
              listener: (context, state) {
                final screenLock = getIt<IScreenLock>();
                if (state.isSignedIn) {
                  _onSignIn(context);
                  screenLock.startTimer();
                  if (state.status == EventStatus.success) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      screenLock.showLock(LockType.setupPin);
                    });
                  }
                  _navigator.pushNamedAndRemoveUntil(
                    DashboardScreen.routeName,
                    (_) => false,
                  );
                } else {
                  screenLock.stopTimer();
                  _navigator.pushNamedAndRemoveUntil(
                    SignInScreen.routeName,
                    (_) => false,
                  );
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listenWhen: (prev, curr) => prev.status != curr.status,
              listener: (context, state) {
                if (state.status == EventStatus.loading) {
                  CustomLoader.display();
                } else if (state.status == EventStatus.error ||
                    state.status == EventStatus.success) {
                  CustomLoader.remove();
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listenWhen: (prev, curr) =>
                  curr.user != null && prev.user == null,
              listener: (context, state) {
                context.read<WalletBloc>().add(InitWallet(state.user!.id));
              },
            ),
          ],
          child: Builder(builder: (context) {
            return InputListener(
              onInput: () {
                if (context.read<AuthBloc>().state.isSignedIn) {
                  getIt<IScreenLock>().resetTimer();
                }
              },
              child: MaterialApp(
                routes: AppConfig.routes,
                title: AppConfig.appName,
                themeMode: ThemeMode.light,
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                theme: LightThemeData(ColorPalette.green).theme,
                home: Builder(builder: (_) {
                  AppSetup.init(_navigator);
                  CustomLoader.init(_navigator);
                  return const SplashScreen();
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
