import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key, required this.icon, this.onPressed})
      : super(key: key);

  final Widget icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkResponse(
            onTap: onPressed,
            child: Padding(padding: const EdgeInsets.all(6), child: icon),
          ),
        ),
      ),
    );
  }
}
