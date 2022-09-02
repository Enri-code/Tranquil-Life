import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/app/presentation/widgets/unfocus_bg.dart';

class CustomBGWidget extends StatelessWidget {
  const CustomBGWidget({Key? key, required this.child, this.title})
      : super(key: key);

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/images/mountains_bg.png'),
            fit: BoxFit.cover,
            color: Colors.black45,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            children: [
              if (title != null)
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
  }
}
