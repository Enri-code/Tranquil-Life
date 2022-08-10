import 'package:flutter/material.dart';
import 'package:tranquil_life/app/presentation/theme/colors.dart';
import 'package:tranquil_life/app/presentation/theme/tranquil_icons.dart';
import 'package:tranquil_life/app/presentation/widgets/custom_app_bar.dart';
import 'package:tranquil_life/app/presentation/widgets/my_default_text_theme.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';

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

  @override
  void didChangeDependencies() {
    consultant = ModalRoute.of(context)!.settings.arguments as Consultant;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: consultant.name),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _DayTimePicker(),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.bottomLeft,
                child: _TimePickerWidget(),
              ),
              const SizedBox(height: 32),
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
                  onPressed: () {},
                  child: const _CardInfo(
                    icon: Icons.calendar_today,
                    title: 'Date',
                    info: '05-08-2022',
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
                onPressed: () {
                  //Icons.warning,
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
  const _TimePickerWidget({Key? key}) : super(key: key);

  @override
  State<_TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<_TimePickerWidget> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MyDefaultTextStyle(
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: List.generate(
          12,
          (i) => GestureDetector(
            onTap: () => setState(() => selectedIndex = i),
            child: _TimeWidget(
              text: '06:00 PM',
              isSelected: selectedIndex == i,
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
