import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key, required this.icon, this.onPressed})
      : super(key: key);

  final Widget icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 3),
            color: Colors.black12,
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
    );
  }
}
