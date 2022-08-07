import 'package:flutter/material.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/tabs/home.dart';
import 'package:tranquil_life/features/dashboard/presentation/widgets/nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'client_dashboard';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
              children: const [
                HomeTab(),
                SizedBox(),
                SizedBox(),
              ],
            ),
          ),
          NavBar(
            onPageChanged: (page) {
              switch (page) {
                case 2:
                  Navigator.of(context)
                      .pushNamed(SpeakWithConsultantScreen.routeName);
                  return;
                case 3:
                  return;
                default:
                  setState(() => currentPage = page);
                  return;
              }
            },
          ),
        ],
      ),
    );
  }
}
