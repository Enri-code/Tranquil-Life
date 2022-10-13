import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';

class DisableAccountDialog extends StatelessWidget {
  const DisableAccountDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bold = TextStyle(fontWeight: FontWeight.bold);
    return InfoDialog(
      infoType: InfoDialogType.warning,
      okayDialog: DialogOption(
        'I understand.',
        autoClose: false,
        onPressed: () {
          AppData.hasShownChatDisableDialog = true;
          Navigator.of(context).pop(true);
        },
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'If, for any reason, you share your ',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 17,
                    height: 1.3,
                  ),
              children: [
                const TextSpan(
                    text: 'email address, phone number', style: bold),
                const TextSpan(text: ', or '),
                const TextSpan(text: 'account details', style: bold),
                const TextSpan(
                  text:
                      ' with a consultant, your account and that of the consultant are at risk of being ',
                ),
                TextSpan(
                  text: 'disabled',
                  style: const TextStyle(color: ColorPalette.red).merge(bold),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
