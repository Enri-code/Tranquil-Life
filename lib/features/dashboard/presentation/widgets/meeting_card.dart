import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const UserAvatar(
            imageUrl:
                'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
          ), //TODO
          const SizedBox(width: 8),
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16, color: Colors.black),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      color: ColorPalette.primary[800],
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        //TODO
                        Expanded(child: Text('Dr. Charles Richard')),
                        SizedBox(width: 4),
                        Text('09:00 pm'),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO
                      const Text('60:00'),
                      Text(
                        '19/08/2022',
                        style: TextStyle(color: ColorPalette.primary[800]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}