import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/user_avatar.dart';

class ChatHistoryCard extends StatelessWidget {
  const ChatHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            children: [
              const UserAvatar(
                size: 48,
                imageUrl:
                    'https://media-exp1.licdn.com/dms/image/C4D03AQG9RwdZxoR3LA/profile-displayphoto-shrink_800_800/0/1641042314872?e=1664409600&v=beta&t=3i2pGW6GJaM47SVvonYStK24fA_OJO3nMbHq8JcFfZk',
              ),
              const SizedBox(width: 24),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Charles Richard',
                    style: TextStyle(color: ColorPalette.green[800]),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '8 hours ago',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 8,
          child: Transform.translate(
            offset: const Offset(0, -6),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorPalette.red,
              ),
              child: const Center(
                child: Text(
                  '1',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
