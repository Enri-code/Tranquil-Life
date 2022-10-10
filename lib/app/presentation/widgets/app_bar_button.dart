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

class BackButtonWhite extends StatelessWidget {
  const BackButtonWhite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'back_button',
      child: AppBarButton(
        backgroundColor: Colors.white,
        icon: Padding(
          padding: const EdgeInsets.all(1),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
