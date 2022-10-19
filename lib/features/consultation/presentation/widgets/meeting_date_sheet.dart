import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tranquil_life/app/presentation/theme/properties.dart';
import 'package:tranquil_life/features/consultation/domain/entities/consultant.dart';
import 'package:tranquil_life/features/consultation/presentation/bloc/consultant/consultant_bloc.dart';

class MeetingDateSheet extends StatelessWidget {
  const MeetingDateSheet(this.consultant, {Key? key, this.onChosen})
      : super(key: key);
  final Consultant consultant;
  final Function()? onChosen;

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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DateCard(
                      DateTime.now().add(Duration(days: index + 1)),
                      consultant: consultant,
                      onChosen: onChosen,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCard extends StatefulWidget {
  const DateCard(this.date, {Key? key, required this.consultant, this.onChosen})
      : super(key: key);

  final DateTime date;
  final Consultant consultant;
  final Function()? onChosen;

  @override
  State<DateCard> createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 72,
      height: 80,
      duration: kThemeChangeDuration,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: selected
            ? Border.all(width: 2, color: Theme.of(context).primaryColor)
            : null,
      ),
      child: InkResponse(
        onTap: () {
          setState(() => selected = true);
          context.read<ConsultantBloc>().add(
                GetConsultantHours(widget.consultant.id, widget.date),
              );
          widget.onChosen?.call();
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('THUR', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text('25TH'),
            ],
          ),
        ),
      ),
    );
  }
}
