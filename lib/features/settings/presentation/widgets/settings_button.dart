import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key? key,
    required this.prefixIconData,
    required this.label,
    required this.onPressed,
    this.suffixWidget,
    this.prefixIconColor,
  }) : super(key: key);

  final String label;
  final IconData prefixIconData;
  final Color? prefixIconColor;
  final Widget? suffixWidget;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      color: Colors.grey[200],
      margin: const EdgeInsets.only(bottom: 4),
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          onTap: onPressed,
          containedInkWell: true,
          highlightShape: BoxShape.rectangle,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 20),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Icon(prefixIconData,
                    color: prefixIconColor ?? Theme.of(context).primaryColor),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(label, style: const TextStyle(fontSize: 18)),
                ),
                const Spacer(),
                suffixWidget ??
                    const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
