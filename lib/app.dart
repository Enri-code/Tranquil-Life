import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/theme/theme_data.dart';
import 'package:tranquil_life/core/utils/helpers/app_init.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/features/auth/data/repos/partners.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/partner/partner_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/consultation/data/repos/consultant_repo.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/journal/data/repos/journal_repo.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/splash.dart';
import 'package:tranquil_life/features/questionnaire/data/repos/questionnaire_repo.dart';
import 'package:tranquil_life/features/questionnaire/presentation/bloc/questionnaire_bloc.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(true);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClientAuthBloc()),
        BlocProvider(create: (_) => PartnerBloc(const PartnersRepoImpl())),
        BlocProvider(create: (_) => JournalBloc(const JournalRepoImpl())),
        BlocProvider(create: (_) => NoteBloc()),
        BlocProvider(create: (_) => ConsultantBloc(const ConsultantRepoImpl())),
        BlocProvider(
          create: (_) => QuestionnaireBloc(const QuestionnaireRepoImpl()),
        ),
      ],
      child: BlocListener<ClientAuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.authStatus != current.authStatus,
        listener: (context, state) {
          if (state.authStatus == AuthStatus.signedIn) {
            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
              DashboardScreen.routeName,
              (_) => false,
            );
          } else if (state.authStatus == AuthStatus.signedOut) {
            _navigatorKey.currentState!.pushNamedAndRemoveUntil(
              SignInScreen.routeName,
              (_) => false,
            );
          }
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: AppConfig.appName,
          theme: MyThemeData.theme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'NG'),
          supportedLocales: const [Locale('en', 'NG')],
          routes: AppConfig.routes,
          home: Builder(builder: (context) {
            AppSetup.init(_navigatorKey.currentState!);
            CustomLoader.init(_navigatorKey.currentState!);
            return const SplashScreen();
          }),
        ),
      ),
    );
  }
}
