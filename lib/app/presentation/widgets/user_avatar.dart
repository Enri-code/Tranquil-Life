import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.imageUrl,
    this.size = 48,
  }) : super(key: key);

  final double size;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey),
      ),
      child: Image.network(
        imageUrl,
        errorBuilder: (_, __, ___) => Icon(
          TranquilIcons.profile,
          color: Colors.grey,
          size: size * 0.9 - 4,
        ),
        frameBuilder: (_, img, val, ___) {
          if (val == null) {
            return SizedBox.square(
              dimension: size * 0.9,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return img;
        },
      ),
    );
  }
}
