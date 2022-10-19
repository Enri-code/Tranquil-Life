part of 'package:tranquil_life/features/dashboard/presentation/screens/home_tab.dart';

class _Meetings extends StatefulWidget {
  const _Meetings({Key? key}) : super(key: key);

  @override
  State<_Meetings> createState() => _MeetingsState();
}

class _MeetingsState extends State<_Meetings> {
  int? meetingsCount = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(blurRadius: 6, color: Colors.black12, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My scheduled meetings',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                width: 44,
                height: 26,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  color: ColorPalette.green[800],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    meetingsCount?.toString() ?? '--',
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Builder(builder: (context) {
              if (meetingsCount == null) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomLoader.widget(),
                );
              }
              if (meetingsCount == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 10, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/no_meeting.png',
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Click the button below to schedule a meeting.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(SpeakWithConsultantScreen.routeName),
                        child: const Text('Schedule a meeting'),
                      ),
                    ],
                  ),
                );
              }
              return Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ListView.builder(
                    itemCount: meetingsCount,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (_) => const _MeetingDialog(
                            consultant: Consultant(
                              id: 0,
                              displayName: 'Dr Rique Blashq',
                            ),
                          ),
                        ),
                        child: const MeetingCard(),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _MeetingDialog extends StatelessWidget {
  const _MeetingDialog({Key? key, required this.consultant}) : super(key: key);
  final Consultant consultant;

  @override
  Widget build(BuildContext context) {
    return OptionsDialog(options: [
      DialogOption(
        'Re-schedule this meeting',
        onPressed: () => showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => _RescheduleMeetingBottomSheet(consultant: consultant),
        ),
      ),
      const DialogOption('Cancel this meeting'),
    ]);
  }
}
