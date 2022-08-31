import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';

enum InfoDialogType { warning, success }

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    Key? key,
    this.text,
    this.type = InfoDialogType.success,
  }) : super(key: key);

  final InfoDialogType? type;
  final String? text;

  Widget _iconBuilder() {
    const padding = EdgeInsets.all(6);
    const margin = EdgeInsets.only(bottom: 16);
    switch (type) {
      case InfoDialogType.success:
        return Container(
          margin: margin,
          padding: padding,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ColorPalette.green,
          ),
          child: const Icon(Icons.check, color: Colors.white),
        );
      case InfoDialogType.warning:
        return Container(
          margin: margin,
          padding: padding,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffEF5656),
          ),
          child: const Icon(Icons.warning_amber, color: Colors.white),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: MyDefaultTextStyle(
        style: const TextStyle(fontSize: 17),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type != null) Builder(builder: (_) => _iconBuilder()),
            if (text != null)
              Text(
                text!,
                style: const TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
