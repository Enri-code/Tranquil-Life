import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/app_bar_button.dart';

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
