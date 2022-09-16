part of 'package:tranquil_life/features/chat/presentation/widgets/chat_more_options.dart';

class _ViewParticipantsDialog extends StatefulWidget {
  const _ViewParticipantsDialog({Key? key}) : super(key: key);

  @override
  State<_ViewParticipantsDialog> createState() =>
      _ViewParticipantsDialogState();
}

class _ViewParticipantsDialogState extends State<_ViewParticipantsDialog> {
  late Animation<Offset> animation;

  @override
  void didChangeDependencies() {
    animation = ModalRoute.of(context)!.animation!.drive(
          Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, child) =>
            SlideTransition(position: animation, child: child!),
        child: Container(
          margin: const EdgeInsets.only(top: 52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ParticipantTile(context.watch<ProfileBloc>().state.user!),
              _ParticipantTile(context.watch<ChatBloc>().state.consultant!),

              //TODO: _ParticipantTile(context.watch<ChatBloc>().state.consultant!),
            ],
          ),
        ),
      ),
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  const _ParticipantTile(this.user, {Key? key}) : super(key: key);

  final User user;

  String get participantType {
    if (user is Consultant) return 'Consultant';
    if (user is Client) return 'You';
    return 'Participant';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(size: 44, imageUrl: user.avatarUrl),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.displayName, style: const TextStyle(fontSize: 17)),
                Text(
                  participantType,
                  style: const TextStyle(
                    color: ColorPalette.blue,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
