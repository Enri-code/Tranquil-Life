import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProfileTabButton extends StatefulWidget {
  const ProfileTabButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPreessed,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Function() onPreessed;

  @override
  State<ProfileTabButton> createState() => _ProfileTabButtonState();
}

class _ProfileTabButtonState extends State<ProfileTabButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => pressed = true),
      onTapUp: (_) => setState(() => pressed = false),
      onTapCancel: () => setState(() => pressed = false),
      child: SizedBox(
        width: 250,
        height: 100,
        child: Neumorphic(
          style: NeumorphicStyle(
            intensity: 1,
            depth: pressed ? -3 : 3,
            color: Colors.grey[200],
            lightSource: LightSource.top,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.icon,
                const SizedBox(height: 4),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
