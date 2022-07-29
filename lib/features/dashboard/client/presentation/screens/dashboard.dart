import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_icon_button.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/widgets/moods.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/widgets/nav_bar.dart';

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.themeColor}) : super(key: key);

  final Color themeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Hi,',
                style: TextStyle(color: themeColor, fontSize: 24),
              ),
            ),
            const Spacer(),
            CustomIconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/users.svg'),
            ),
            const SizedBox(width: 12),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CustomIconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/bell.svg'),
                ),
                Transform.translate(
                  offset: const Offset(12, -10),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const SizedBox(
                      width: 20,
                      child: Center(
                        child: Text(
                          '8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Enrique!',
          style: TextStyle(
            color: themeColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _DarkModeSwitch extends StatelessWidget {
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
}

class ClientDashboardScreen extends StatelessWidget {
  static const routeName = 'client_dashboard';

  const ClientDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _BG(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DarkModeSwitch(themeColor: themeColor),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
                        iconSize: 28,
                        icon: const Icon(Icons.more_vert),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Title(themeColor: themeColor),
                        const SizedBox(height: 32),
                        //
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Column(
                              //mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Your scheduled meetings',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Container(
                                      width: 44,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: ColorPalette.primary[800],
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '4',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const MoodsListView(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const ClientNavBar(),
    );
  }
}

class _BG extends StatelessWidget {
  const _BG({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.42,
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
    );
  }
}
