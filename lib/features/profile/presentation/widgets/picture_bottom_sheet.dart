import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';

class AddPictureSheet extends StatelessWidget {
  const AddPictureSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        child: MyDefaultTextStyle(
          style: TextStyle(
            color: ColorPalette.green[800],
            fontWeight: FontWeight.w600,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Button(
                title: 'Take a picture',
                iconData: Icons.camera_alt,
                onPressed: () {},
              ),
              _Button(
                title: 'Upload from gallery',
                iconData: Icons.image,
                onPressed: () {},
              ),
              _Button(
                title: 'Use a bitmoji',
                child: Image.asset('assets/images/icons/bitmoji.png'),
                onPressed: () {},
              ),
              _Button(
                title: 'Remove picture',
                iconData: TranquilIcons.trash,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.title,
    this.iconData,
    this.child,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData? iconData;
  final Widget? child;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () {
          onPressed();
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              if (iconData != null)
                Icon(iconData, color: Theme.of(context).primaryColor, size: 28),
              if (child != null) child!,
              const SizedBox(width: 24),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
