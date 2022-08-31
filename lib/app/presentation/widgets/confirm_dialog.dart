import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';

class DialogOption {
  final bool autoClose;
  final String title;
  final Function()? onPressed;

  const DialogOption(this.title, {this.onPressed, this.autoClose = true});
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title,
    this.bodyText,
    this.body,
    this.yesDialog,
    this.noDialog = const DialogOption('Cancel'),
  })  : assert(bodyText != null || body != null),
        super(key: key);

  final String? title;
  final String? bodyText;
  final Widget? body;
  final DialogOption? yesDialog, noDialog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: MyDefaultTextStyle(
        style: const TextStyle(fontSize: 17),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Builder(builder: (context) {
                return body ??
                    Text(
                      bodyText!,
                      style: const TextStyle(
                        height: 1.3,
                        color: Color.fromARGB(255, 82, 82, 82),
                      ),
                    );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (noDialog != null)
                  TextButton(
                    onPressed: () {
                      if (noDialog!.autoClose) Navigator.of(context).pop();
                      noDialog!.onPressed?.call();
                    },
                    child: Text(
                      noDialog!.title,
                      style: const TextStyle(
                        color: ColorPalette.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                if (yesDialog != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextButton(
                      onPressed: () {
                        if (yesDialog!.autoClose) Navigator.of(context).pop();
                        yesDialog!.onPressed?.call();
                      },
                      child: Text(
                        yesDialog!.title,
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
