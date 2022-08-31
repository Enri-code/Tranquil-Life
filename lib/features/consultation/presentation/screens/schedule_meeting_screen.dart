import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/core/utils/extensions/date_time_extension.dart';
import 'package:tranquil_life/core/utils/services/app_data_store.dart';
import 'package:tranquil_life/core/utils/services/functions.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/consultation/presentation/widgets/meeting_absence_warning_dialog.dart';

part '../widgets/schedule_meeting_widgets.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  ///Argument is [Consultant]
  static const routeName = 'schedule_meeting_screen';
  const ScheduleMeetingScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  late Consultant consultant;
  String? date;
  String? time;

  @override
  void didChangeDependencies() {
    consultant = ModalRoute.of(context)!.settings.arguments as Consultant;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: consultant.displayName),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _DayTimePicker(),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerLeft,
                child: _TimePickerWidget(
                  date: date,
                  onTimeChosen: (chosenTime) =>
                      setState(() => time = chosenTime),
                ),
              ),
              SizedBox(
                height: 80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: Colors.white,
                    onPrimary: Theme.of(context).primaryColor,
                    surfaceTintColor: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                  ),
                  onPressed: () async {
                    var chosenDate = await showCustomDatePicker(
                      context,
                      minDateFromNow: DateTime(0, 0),
                      maxDateFromNow: DateTime(0),
                    );
                    setState(() => date = chosenDate?.folded);
                  },
                  child: _CardInfo(
                    icon: Icons.calendar_today,
                    title: 'Date',
                    info: date ?? 'Select a date',
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const _CardInfo(
                  icon: TranquilIcons.card,
                  title: 'Fee',
                  info: r'$35.00',
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: date == null || time == null
                    ? null
                    : () {
                        if (!AppData.hasReadMeetingAbsenceMessage) {
                          showDialog(
                            context: context,
                            barrierColor: const Color(0x9D000000),
                            builder: (_) => const MeetingAbsenceWarningDialog(),
                          );
                          return;
                        }
                        context
                            .read<ConsultantBloc>()
                            .add(const BookConsultation());
                      },
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimePickerWidget extends StatefulWidget {
  const _TimePickerWidget({
    Key? key,
    required this.date,
    required this.onTimeChosen,
  }) : super(key: key);

  final String? date;
  final Function(String time) onTimeChosen;

  @override
  State<_TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<_TimePickerWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.centerLeft,
      child: MyDefaultTextStyle(
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        child: widget.date == null
            ? const SizedBox(height: 16)
            : Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(
                    12,
                    (i) {
                      var time = '06:00 PM';
                      return GestureDetector(
                        onTap: () {
                          widget.onTimeChosen(time);
                          setState(() => selectedIndex = i);
                        },
                        child: _TimeWidget(
                          text: time,
                          isSelected: selectedIndex == i,
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}

class _DayTimePicker extends StatefulWidget {
  const _DayTimePicker({Key? key}) : super(key: key);

  @override
  State<_DayTimePicker> createState() => _DayTimePickerState();
}

class _DayTimePickerState extends State<_DayTimePicker> {
  bool isNightSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _DayTimeWidget(
            title: 'Daytime',
            icon: TranquilIcons.bright,
            isSelected: !isNightSelected,
            onPressed: () {
              setState(() => isNightSelected = false);
            },
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _DayTimeWidget(
            title: 'Nighttime',
            icon: TranquilIcons.night,
            isSelected: isNightSelected,
            onPressed: () {
              setState(() => isNightSelected = true);
            },
          ),
        ),
      ],
    );
  }
}
