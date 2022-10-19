import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/widgets/dialogs.dart';
import 'package:tranquil_life/features/chat/presentation/widgets/dialogs/topup_dialog.dart';

class ExtendSessionDialog extends StatelessWidget {
  const ExtendSessionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmDialog(
      yesDialog: DialogOption(
        'Extend',
        onPressed: () {
          showDialog(context: context, builder: (_) => const TopupDialog());
        },
      ),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/stroked_circle.png'),
                  const Text(
                    '5',
                    style: TextStyle(fontSize: 76, color: ColorPalette.red),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'mins left',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Do you want to extend this session by one hour?\n\n'
            'The fees will be deducted from your wallet balance.',
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
