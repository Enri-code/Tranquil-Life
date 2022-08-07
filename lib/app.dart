import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/theme/theme_data.dart';
import 'package:tranquil_life/core/utils/helpers/app_init.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/core/utils/services/custom_loader.dart';
import 'package:tranquil_life/features/auth/presentation/bloc/client_auth.dart';
import 'package:tranquil_life/features/consultation/data/repos/consultant_repo.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/dashboard.dart';
import 'package:tranquil_life/features/journal/data/repos/journal_repo.dart';
import 'package:tranquil_life/features/journal/presentation/bloc/journal/journal_bloc.dart';
import 'package:tranquil_life/features/onboarding/presentation/screens/splash.dart';
import 'package:tranquil_life/features/questionnaire/data/repos/questionnaire_repo.dart';
import 'package:tranquil_life/features/questionnaire/presentation/bloc/questionnaire_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(true);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ClientAuthBloc()),
        BlocProvider(create: (_) => JournalBloc(JournalRepoImpl())),
        BlocProvider(create: (_) => ConsultantBloc(ConsultantRepoImpl())),
        BlocProvider(create: (_) => QuestionnaireBloc(QuestionnaireRepoImpl())),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        theme: MyThemeData.theme,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'NG'),
        supportedLocales: const [Locale('en', 'NG')],
        routes: AppConfig.routes,
        home: Builder(builder: (context) {
          AppSetup.init(context);
          CustomLoader.init(context);
          return const SplashScreen();
          //return const DashboardScreen();
        }),
      ),
    );
  }
}
