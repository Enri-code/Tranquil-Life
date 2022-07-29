import 'package:flutter/material.dart';
import 'package:tranquil_life/app/config.dart';
import 'package:tranquil_life/app/presentation/theme/theme_data.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/dashboard.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setStatusBarBrightness(true);
    return MaterialApp(
      title: AppConfig.appName,
      theme: MyThemeData.theme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'NG'),
      supportedLocales: const [Locale('en', 'NG')],
      routes: AppConfig.routes,
      home: ClientDashboardScreen(),
    );
  }
}
