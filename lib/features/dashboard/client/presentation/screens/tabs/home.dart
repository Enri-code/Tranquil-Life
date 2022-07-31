import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_icon_button.dart';
import 'package:tranquil_life/features/notifications/presentation/screens/notifications.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/widgets/meeting_card.dart';
import 'package:tranquil_life/features/dashboard/client/presentation/widgets/moods.dart';

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
              icon: SvgPicture.asset('assets/icons/users.svg', width: 28),
            ),
            const SizedBox(width: 12),
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(NotificationScreen.routeName);
                  },
                  icon: SvgPicture.asset('assets/icons/bell.svg', width: 28),
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
        const SizedBox(height: 8),
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

class ClientHomeTab extends StatelessWidget {
  const ClientHomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const _BG(),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: /* Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DarkModeSwitch(themeColor: themeColor),
                      const SizedBox(width: 8), */
                    _Popup(),

                /*    const SizedBox(width: 8),
                    ],
                  ), */
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Title(themeColor: Theme.of(context).primaryColor),
                            const SizedBox(height: 32),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.45,
                              child: const _Meetings(),
                            ),
                            const SizedBox(height: 40),
                            const MoodsListView(),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Popup extends StatelessWidget {
  const _Popup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) => [
        const PopupMenuItem(value: 0, child: Text('Our blog')),
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Sign out'),
              const SizedBox(width: 8),
              SvgPicture.asset('assets/icons/logout.svg'),
            ],
          ),
        ),
      ],
      onSelected: (int val) {
        //TODO
        switch (val) {
          case 0:
            break;
          case 1:
            break;
        }
      },
    );
  }
}

class _BG extends StatelessWidget {
  const _BG({Key? key}) : super(key: key);

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

class _Meetings extends StatelessWidget {
  const _Meetings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 4, 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your scheduled meetings',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: 44,
                height: 28,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  color: ColorPalette.primary[800],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Text(
                    '4',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Scrollbar(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: ListView.builder(
                  itemCount: 8,
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: MeetingCard(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
