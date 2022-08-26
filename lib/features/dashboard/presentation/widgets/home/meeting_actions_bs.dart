part of 'package:tranquil_life/features/dashboard/presentation/screens/tabs/home.dart';

class _RescheduleMeetingBottomSheet extends StatelessWidget {
  const _RescheduleMeetingBottomSheet({
    Key? key,
  }) : super(key: key);

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
            const Text(
              'What is your reason for rescheduling this meeting?',
            ),
            const SizedBox(height: 24),
            const TextField(
              minLines: 3,
              maxLines: 8,
              decoration: InputDecoration(
                hintText:
                    'I have an urgent work meeting with top executives 30 mintues before the time of this meeting.'
                    ' So, it is best that I reschedule this meeting.',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Reschedule Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
