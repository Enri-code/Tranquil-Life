import 'package:flutter/material.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/screens/tabs/home.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/widgets/nav_bar.dart';

/* class _DarkModeSwitch extends StatelessWidget {
  const _DarkModeSwitch({
    Key? key,
    required this.themeColor,
  }) : super(key: key);

  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 38,
      height: 22,
      padding: 2,
      toggleSize: 18,
      borderRadius: 30,
      activeColor: themeColor,
      value: false,
      onToggle: (val) {},
    );
  }
} */

class ClientDashboardScreen extends StatefulWidget {
  static const routeName = 'client_dashboard';

  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ClientDashboardScreen> createState() => _ClientDashboardScreenState();
}

class _ClientDashboardScreenState extends State<ClientDashboardScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            bottom: 94,
            child: IndexedStack(
              index: currentPage,
              sizing: StackFit.expand,
              children: [
                ClientHomeTab(),
              ],
            ),
          ),
          ClientNavBar(
            onPageChanged: (page) {
              if (page != null) {
                setState(() => currentPage = page);
              } else {
                Navigator.of(context)
                    .pushNamed(SpeakWithConsultantScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
