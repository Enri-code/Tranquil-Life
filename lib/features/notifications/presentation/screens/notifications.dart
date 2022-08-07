import 'package:flutter/material.dart';
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
          itemBuilder: (_, index) => NotificationCard(),
        ),
      ),
    );
  }
}
