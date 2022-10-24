import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/theme/properties.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';
import 'package:tranquil_life/features/consultation/presentation/screens/schedule_meeting_screen.dart';

class MeetingDateSheet extends StatefulWidget {
  const MeetingDateSheet(this.consultant, {Key? key}) : super(key: key);
  final Consultant consultant;

  @override
  State<MeetingDateSheet> createState() => _MeetingDateSheetState();
}

class _MeetingDateSheetState extends State<MeetingDateSheet> {
  DateTime? selectedDate;
  late final List<DateTime> days;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    days = List.generate(7, (index) {
      return DateTime(now.year, now.month, now.day + index + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: bottomSheetDecoration.copyWith(color: Colors.grey[100]),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 24),
              child: Text(
                'Select a date',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: days.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, index) {
                  final date = days[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DateCard(
                      date,
                      consultant: widget.consultant,
                      selected: selectedDate == date,
                      onChosen: () => setState(() => selectedDate = date),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Center(
                child: ElevatedButton(
                  onPressed: selectedDate != null
                      ? () {
                          context.read<ConsultantBloc>().add(
                                GetConsultantHours(
                                  widget.consultant.id,
                                  selectedDate!,
                                ),
                              );
                          Navigator.of(context).popAndPushNamed(
                            ScheduleMeetingScreen.routeName,
                            arguments: widget.consultant,
                          );
                        }
                      : null,
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  const DateCard(
    this.date, {
    Key? key,
    required this.consultant,
    required this.selected,
    this.onChosen,
  }) : super(key: key);

  final DateTime date;
  final bool selected;
  final Consultant consultant;
  final Function()? onChosen;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 70,
      height: 80,
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: selected ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(8),
        /*  border: selected
            ? Border.all(width: 2, color: Theme.of(context).primaryColor)
            : null, */
      ),
      child: InkResponse(
        onTap: () => onChosen?.call(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'THUR',
                style: TextStyle(
                  color: selected ? Colors.grey[300] : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '25',
                style: TextStyle(
                  fontSize: 20,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
