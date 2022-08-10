import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';

class AuthBGWidget extends StatelessWidget {
  const AuthBGWidget({Key? key, required this.child, this.title})
      : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/mountains_bg.png',
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.overlay,
          ),
          Column(
            children: [
              CustomAppBar(title: title, titleColor: Colors.white),
              Expanded(
                child: SafeArea(
                  top: false,
                  child: UnfocusWidget(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: MyDefaultTextStyle(
                        style: const TextStyle(color: Colors.white),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    /*  return Image.asset(
      'assets/images/mountains_bg.png',
      fit: BoxFit.cover,
      color: Colors.black38,
      colorBlendMode: BlendMode.overlay,
    ); */
  }
}
