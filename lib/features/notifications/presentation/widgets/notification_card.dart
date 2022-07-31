import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';
import 'package:tranquil_life/features/notifications/domain/entities/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
  }) : super(key: key);

  static Widget _iconFromType(NotificationType type) {
    switch (type) {
      case NotificationType.meeting:
        return const Padding(
          padding: EdgeInsets.all(1),
          child: Icon(Icons.calendar_month, color: Colors.white, size: 27),
        );
      case NotificationType.contact:
        return const Icon(TranquilIcons.profile, color: Colors.white, size: 29);
      case NotificationType.message:
        return Padding(
          padding: const EdgeInsets.all(2.5),
          child: SvgPicture.asset(
            'assets/icons/message.svg',
            color: Colors.white,
            width: 24,
          ),
        );
      default:
        return SvgPicture.asset(
          'assets/icons/bell.svg',
          color: Colors.white,
          width: 28,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const UserAvatar(
                imageUrl:
                    'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: Colors.black,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('23 minutes ago'),
                      SizedBox(height: 8),
                      Text(
                        'You scheduled a meeting with Dr. Charles Richards for Aug 19, 2022, 09:00 pm.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
        Positioned(
          right: 24,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _iconFromType(NotificationType.notification),
          ),
        ),
      ],
    );
  }
}
