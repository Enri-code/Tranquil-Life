import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Button(
              icon: Icons.videocam_off,
              onPressed: () {},
            ),
            _Button(
              icon: Icons.call_end,
              backgroundColor: Colors.white,
              iconColor: ColorPalette.red,
              onPressed: () {},
            ),
            _Button(
              icon: Icons.mic_off,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.black26,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor, backgroundColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          onTap: onPressed,
          containedInkWell: true,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: iconColor, size: 36),
          ),
        ),
      ),
    );
  }
}
