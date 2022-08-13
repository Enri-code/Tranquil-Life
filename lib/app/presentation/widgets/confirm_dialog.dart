import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';

class DialogOption {
  final String title;
  final Function()? onPressed;

  const DialogOption(this.title, [this.onPressed]);
}

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title,
    this.body,
    this.yesDialog,
    this.noDialog = const DialogOption('Cancel'),
  })  : assert(title != null || body != null),
        super(key: key);

  final String? title;
  final String? body;
  final DialogOption? yesDialog, noDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: MyDefaultTextStyle(
        style: const TextStyle(fontSize: 20),
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
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (body != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  body!,
                  style: const TextStyle(
                    height: 1.3,
                    color: Color.fromARGB(255, 82, 82, 82),
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (noDialog != null)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      noDialog!.onPressed?.call();
                    },
                    child: Text(
                      noDialog!.title,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (yesDialog != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        yesDialog!.onPressed?.call();
                      },
                      child: Text(
                        yesDialog!.title,
                        style: const TextStyle(color: Colors.green),
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
