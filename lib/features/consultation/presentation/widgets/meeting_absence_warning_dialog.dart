import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/text.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';

class MeetingAbsenceWarningDialog extends StatelessWidget {
  const MeetingAbsenceWarningDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning, color: ColorPalette.yellow, size: 32),
          const SizedBox(height: 8),
          RichText(
            text: const TextSpan(
              text: 'Please note:',
              children: [
                TextSpan(
                  text:
                      ' If you are not present 10 mins after the session starts, you would be marked as absent.'
                      "\n\nBeing marked absent means that you'll lose 50% of the fee.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
              style: TextStyle(
                height: 1.5,
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: MyTextData.josefinFamily,
              ),
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              AppData.hasReadMeetingAbsenceMessage = true;
              context.read<ConsultantBloc>().add(const BookConsultation());
              Navigator.of(context).pop();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
