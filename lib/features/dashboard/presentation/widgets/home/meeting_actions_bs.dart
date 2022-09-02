part of 'package:tranquil_life/features/dashboard/presentation/screens/home_tab.dart';

class _RescheduleMeetingBottomSheet extends StatefulWidget {
  const _RescheduleMeetingBottomSheet({
    Key? key,
    required this.consultant,
  }) : super(key: key);
  final Consultant consultant;

  @override
  State<_RescheduleMeetingBottomSheet> createState() =>
      _RescheduleMeetingBottomSheetState();
}

class _RescheduleMeetingBottomSheetState
    extends State<_RescheduleMeetingBottomSheet> {
  String reasonText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('What is your reason for rescheduling this meeting?'),
            const SizedBox(height: 24),
            TextField(
              minLines: 3,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText:
                    'I have an urgent work meeting with top executives 30 mintues before the time of this meeting.'
                    ' So, it is best that I reschedule this meeting.',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              onChanged: (val) => reasonText = val,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.of(context).popAndPushNamed(
                ScheduleMeetingScreen.routeName,
                arguments: widget.consultant,
              ),
              child: const Text('Reschedule Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
