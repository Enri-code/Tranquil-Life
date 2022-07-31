import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/features/notifications/presentation/widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  static const routeName = 'notifications';
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notifications'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (_, index) => _Notification(),
        ),
      ),
    );
  }
}

class _Notification extends StatelessWidget {
  const _Notification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onLeftSwipe: () {
        //TODO
      },
      leftSwipeWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorPalette.secondary[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset('assets/icons/trash.svg', width: 26),
      ),
      child: NotificationCard(),
    );
  }
}
