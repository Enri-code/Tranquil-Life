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
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(9),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).primaryColor,
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white, size: 22),
              ),
              child: icon,
            ),
          ),
          if (onPressed != null)
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkResponse(
                  onTap: onPressed,
                  containedInkWell: true,
                  highlightShape: BoxShape.rectangle,
                ),
              ),
            )
        ],
      ),
    );
  }
}
