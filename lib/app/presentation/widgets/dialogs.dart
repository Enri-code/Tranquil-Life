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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: MyDefaultTextStyle(
          style: const TextStyle(fontSize: 16, color: Colors.black),
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
              Theme(
                data: Theme.of(context).copyWith(
                    textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (noDialog != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: TextButton(
                          onPressed: () {
                            if (noDialog!.autoClose) {
                              Navigator.of(context).pop();
                            }
                            noDialog!.onPressed?.call();
                          },
                          child: Text(
                            noDialog!.title,
                            style: const TextStyle(color: ColorPalette.red),
                          ),
                        ),
                      ),
                    if (yesDialog != null)
                      TextButton(
                        onPressed: () {
                          if (yesDialog!.autoClose) Navigator.of(context).pop();
                          yesDialog!.onPressed?.call();
                        },
                        child: Text(
                          yesDialog!.title,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsDialog extends StatelessWidget {
  const OptionsDialog(this.options, {Key? key}) : super(key: key);
  final List<DialogOption> options;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: options
              .map<Widget>((e) => _DialogButton(
                    title: e.title,
                    onPressed: () {
                      if (e.autoClose) Navigator.of(context).pop();
                      e.onPressed?.call();
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      containedInkWell: true,
      highlightShape: BoxShape.rectangle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Text(title),
      ),
    );
  }
}
