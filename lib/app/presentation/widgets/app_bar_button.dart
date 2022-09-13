import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final Widget icon;
  final Color? backgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: backgroundColor ?? Theme.of(context).primaryColor,
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white, size: 22),
          ),
          child: icon,
        ),
      ),
    );
  }
}
