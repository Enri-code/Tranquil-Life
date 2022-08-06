import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/questions.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/tabs/home.dart';
import 'package:tranquil_life/features/dashboard/presentation/widgets/nav_bar.dart';
import 'package:tranquil_life/features/journal/presentation/screens/journal.dart';

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
                JournalsScreen(),
              ],
            ),
          ),
          NavBar(
            onPageChanged: (page) {
              switch (page) {
                case 2:
                  Navigator.of(context)
                      .pushNamed(SpeakWithConsultantScreen.routeName);
                  return false;
                /*  case 3:
                  return false; */
                default:
                  setState(() => currentPage = page);
                  return true;
              }
            },
          ),
        ],
      ),
    );
  }
}
