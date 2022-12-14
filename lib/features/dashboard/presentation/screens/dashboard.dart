import 'package:flutter/material.dart';
import 'package:tranquil_life/core/utils/functions.dart';
import 'package:tranquil_life/features/chat/presentation/screens/chat_screen.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/speak_with_consultant.dart';
import 'package:tranquil_life/features/dashboard/presentation/screens/home_tab.dart';
import 'package:tranquil_life/features/dashboard/presentation/widgets/nav_bar.dart';
import 'package:tranquil_life/features/profile/presentation/screens/profile_tab.dart';
import 'package:tranquil_life/features/wallet/presentation/screens/wallet_tab.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = 'dashboard_screen';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentPage = 0;

  @override
  void initState() {
    setStatusBarBrightness(true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage('assets/images/chat_bg.png'), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).padding.bottom + 62,
            child: IndexedStack(
              index: currentPage,
              sizing: StackFit.expand,
              children: const [
                HomeTab(),
                WalletTab(),
                ProfileScreen(),
              ],
            ),
          ),
          NavBar(
            onPageChanged: (page) {
              FocusManager.instance.primaryFocus?.unfocus();
              switch (page) {
                case 3:
                  if (true) //TODO: if in a meeting
                  {
                    Navigator.of(context).pushNamed(ChatScreen.routeName);
                  } else {
                    Navigator.of(context)
                        .pushNamed(SpeakWithConsultantScreen.routeName);
                  }
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
