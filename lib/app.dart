import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/theme_data.dart';
import 'package:tranquil_life/core/utils/helpers/app_init.dart';
import 'package:tranquil_life/core/utils/helpers/operation_status.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/core/utils/helpers/custom_loader.dart';
import 'package:tranquil_life/core/utils/services/location_service.dart';
import 'package:tranquil_life/features/auth/data/repos/partners.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/partner/partner_bloc.dart';
import 'package:tranquil_life/features/auth/presentation/screens/sign_in.dart';
import 'package:tranquil_life/features/chat/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:tranquil_life/features/consultation/data/repos/consultant_repo.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/journal/data/repos/journal_repo.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/note/note_bloc.dart';
import 'package:tranquil_life/features/lock/domain/lock.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/splash.dart';
import 'package:tranquil_life/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tranquil_life/features/questionnaire/data/repos/questionnaire_repo.dart';
import 'package:tranquil_life/features/questionnaire/presentation/bloc/questionnaire_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/edit_card/edit_card_bloc.dart';
import 'package:tranquil_life/features/wallet/presentation/bloc/wallet/wallet_bloc.dart';
import 'package:tranquil_life/samples/notes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  _onSignIn(BuildContext context) {
    context.read<ProfileBloc>().add(const RestoreUserProfile());
    context.read<JournalBloc>().add(GetNotes(notes));
    context.read<ProfileBloc>().add(const UpdateProfileLocation(
          'Getting location...',
        ));
    LocationService.requestLocation().then((value) {
      context.read<ProfileBloc>().add(UpdateProfileLocation(value));
    });
  }

  _onSignOut(BuildContext context) {
    context.read<WalletBloc>().add(const ClearWallet());
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) getIt<IScreenLock>().authenticate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(true);
    precacheImage(const AssetImage('assets/images/mountains_bg.png'), context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClientAuthBloc(), lazy: false),
        BlocProvider(create: (_) => ProfileBloc(), lazy: false),
        BlocProvider(create: (_) => PartnerBloc(const PartnersRepoImpl())),
        BlocProvider(create: (_) => ConsultantBloc(const ConsultantRepoImpl())),
        BlocProvider(create: (_) => JournalBloc(const JournalRepoImpl())),
        BlocProvider(create: (_) => NoteBloc()),
        BlocProvider(create: (_) => ChatBloc()),
        BlocProvider(create: (_) => EditCardBloc()),
        BlocProvider(create: (_) => WalletBloc()),
        BlocProvider(
          create: (_) => QuestionnaireBloc(const QuestionnaireRepoImpl()),
        ),
      ],
      child: BlocListener<ClientAuthBloc, AuthState>(
        listenWhen: (prev, curr) {
          if (curr.authStatus == AuthStatus.signedOut) return true;
          return prev.authStatus != curr.authStatus;
        },
        listener: (context, state) {
          if (state.authStatus == AuthStatus.signedIn) {
            _onSignIn(context);
            _navigator.pushNamedAndRemoveUntil(
              DashboardScreen.routeName,
              (_) => false,
            );
          } else if (state.authStatus == AuthStatus.signedOut) {
            _onSignOut(context);
            _navigator.pushNamedAndRemoveUntil(
              SignInScreen.routeName,
              (_) => false,
            );
          }
        },
        child: BlocListener<ClientAuthBloc, AuthState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            if (state.status == OperationStatus.loading) {
              CustomLoader.display();
            } else {
              CustomLoader.remove();
            }
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listenWhen: (prev, curr) => curr.user != null && prev.user == null,
            listener: (context, state) {
              context.read<WalletBloc>().add(InitWallet(state.user!.id));
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
          ),
        ),
      ),
    );
  }
}
